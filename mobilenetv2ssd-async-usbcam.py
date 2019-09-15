import argparse
#import platform
import numpy as np
import cv2
import time
#from PIL import Image
from time import sleep
import multiprocessing as mp
try:
    from tflite_runtime.interpreter import Interpreter
except:
    import tensorflow as tf


lastresults = None
processes = []
frameBuffer = None
results = None
fps = ""
detectfps = ""
framecount = 0
detectframecount = 0
time1 = 0
time2 = 0
box_color = (255, 128, 0)
box_thickness = 1
label_background_color = (125, 175, 75)
label_text_color = (255, 255, 255)
percentage = 0.0

LABELS = [
'???','person','bicycle','car','motorcycle','airplane','bus','train','truck','boat',
'traffic light','fire hydrant','???','stop sign','parking meter','bench','bird','cat','dog','horse',
'sheep','cow','elephant','bear','zebra','giraffe','???','backpack','umbrella','???',
'???','handbag','tie','suitcase','frisbee','skis','snowboard','sports ball','kite','baseball bat',
'baseball glove','skateboard','surfboard','tennis racket','bottle','???','wine glass','cup','fork','knife',
'spoon','bowl','banana','apple','sandwich','orange','broccoli','carrot','hot dog','pizza',
'donut','cake','chair','couch','potted plant','bed','???','dining table','???','???',
'toilet','???','tv','laptop','mouse','remote','keyboard','cell phone','microwave','oven',
'toaster','sink','refrigerator','???','book','clock','vase','scissors','teddy bear','hair drier',
'toothbrush']


class ObjectDetectorLite():
    def __init__(self, model_path='detect.tflite', threads_num=4):
        try:
            self.interpreter = Interpreter(model_path=model_path)
            self.interpreter.set_num_threads(threads_num)
        except:
            self.interpreter = tf.lite.Interpreter(model_path=model_path)
            self.interpreter.set_num_threads(threads_num)
        self.interpreter.allocate_tensors()
        self.input_details = self.interpreter.get_input_details()
        self.output_details = self.interpreter.get_output_details()

    def _boxes_coordinates(self,
                            image,
                            boxes,
                            classes,
                            scores,
                            max_boxes_to_draw=20,
                            min_score_thresh=.5):

        if not max_boxes_to_draw:
            max_boxes_to_draw = boxes.shape[0]
        number_boxes = min(max_boxes_to_draw, boxes.shape[0])
        person_boxes = []
        for i in range(number_boxes):
            if scores is None or scores[i] > min_score_thresh:
                box = tuple(boxes[i].tolist())
                ymin, xmin, ymax, xmax = box
                im_height, im_width, _ = image.shape
                left, right, top, bottom = [int(z) for z in (xmin * im_width, xmax * im_width, ymin * im_height, ymax * im_height)]
                person_boxes.append([(left, top), (right, bottom), scores[i], LABELS[classes[i]]])
        return person_boxes


    def detect(self, image, threshold=0.1):
        # Resize and normalize image for network input
        frame = cv2.resize(image, (300, 300))
        frame = np.expand_dims(frame, axis=0)
        frame = frame.astype('uint8')

        # run model
        self.interpreter.set_tensor(self.input_details[0]['index'], frame)
        start_time = time.time()
        self.interpreter.invoke()
        stop_time = time.time()
        print("time: ", stop_time - start_time)

        # get results
        boxes = self.interpreter.get_tensor(self.output_details[0]['index'])
        classes = self.interpreter.get_tensor(self.output_details[1]['index'])
        scores = self.interpreter.get_tensor(self.output_details[2]['index'])
        num = self.interpreter.get_tensor(self.output_details[3]['index'])

        # Find detected boxes coordinates
        return self._boxes_coordinates(image,
                            np.squeeze(boxes[0]),
                            np.squeeze(classes[0]+1).astype(np.int32),
                            np.squeeze(scores[0]),
                            min_score_thresh=threshold)


def camThread(results, frameBuffer, camera_width, camera_height, vidfps, usbcamno):

    global fps
    global detectfps
    global framecount
    global detectframecount
    global time1
    global time2
    global lastresults
    global cam
    global window_name

    cam = cv2.VideoCapture(usbcamno)
    cam.set(cv2.CAP_PROP_FPS, vidfps)
    cam.set(cv2.CAP_PROP_FRAME_WIDTH, camera_width)
    cam.set(cv2.CAP_PROP_FRAME_HEIGHT, camera_height)
    window_name = "USB Camera"
    cv2.namedWindow(window_name, cv2.WINDOW_AUTOSIZE)

    while True:
        t1 = time.perf_counter()

        ret, color_image = cam.read()
        if not ret:
            continue
        if frameBuffer.full():
            frameBuffer.get()
        frames = color_image
        frameBuffer.put(color_image.copy())
        res = None

        if not results.empty():
            res = results.get(False)
            detectframecount += 1
            imdraw = overlay_on_image(frames, res, camera_width, camera_height)
            lastresults = res
        else:
            imdraw = overlay_on_image(frames, lastresults, camera_width, camera_height)

        cv2.imshow('USB Camera', imdraw)

        if cv2.waitKey(1)&0xFF == ord('q'):
            break

        # FPS calculation
        framecount += 1
        if framecount >= 15:
            fps       = "(Playback) {:.1f} FPS".format(time1/15)
            detectfps = "(Detection) {:.1f} FPS".format(detectframecount/time2)
            framecount = 0
            detectframecount = 0
            time1 = 0
            time2 = 0
        t2 = time.perf_counter()
        elapsedTime = t2-t1
        time1 += 1/elapsedTime
        time2 += elapsedTime



def inferencer(results, frameBuffer, model, camera_width, camera_height, process_num, threads_num):

    detector = ObjectDetectorLite(model, threads_num)
    print("Loaded Graphs!!!", process_num)

    while True:

        if frameBuffer.empty():
            continue

        # Run inference.
        color_image = frameBuffer.get()
        prepimg = color_image[:, :, ::-1].copy()
        ans = detector.detect(prepimg, 0.4)
        results.put(ans)



def overlay_on_image(frames, object_infos, camera_width, camera_height):

    color_image = frames

    if isinstance(object_infos, type(None)):
        return color_image
    img_cp = color_image.copy()

    for obj in object_infos:
        box_left = int(obj[0][0])
        box_top = int(obj[0][1])
        box_right = int(obj[1][0])
        box_bottom = int(obj[1][1])
        cv2.rectangle(img_cp, (box_left, box_top), (box_right, box_bottom), box_color, box_thickness)

        percentage = int(obj[2] * 100)
        label_text = obj[3] + " (" + str(percentage) + "%)" 

        label_size = cv2.getTextSize(label_text, cv2.FONT_HERSHEY_SIMPLEX, 0.5, 1)[0]
        label_left = box_left
        label_top = box_top - label_size[1]
        if (label_top < 1):
            label_top = 1
        label_right = label_left + label_size[0]
        label_bottom = label_top + label_size[1]
        cv2.rectangle(img_cp, (label_left - 1, label_top - 1), (label_right + 1, label_bottom + 1), label_background_color, -1)
        cv2.putText(img_cp, label_text, (label_left, label_bottom), cv2.FONT_HERSHEY_SIMPLEX, 0.5, label_text_color, 1)

    cv2.putText(img_cp, fps,       (camera_width-170,15), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (38,0,255), 1, cv2.LINE_AA)
    cv2.putText(img_cp, detectfps, (camera_width-170,30), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (38,0,255), 1, cv2.LINE_AA)

    return img_cp

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument("--model", default="models/mobilenet_ssd_v2_coco_quant_postprocess.tflite", help="Path of the detection model.")
    parser.add_argument("--label", default="coco_labels.txt", help="Path of the labels file.")
    parser.add_argument("--usbcamno", type=int, default=0, help="USB Camera number.")
    args = parser.parse_args()

    model    = args.model
    usbcamno = args.usbcamno

    camera_width = 640
    camera_height = 480
    vidfps = 60
    #core_num = mp.cpu_count()
    core_num    = 1
    threads_num = 10

    try:
        mp.set_start_method('forkserver')
        frameBuffer = mp.Queue(10)
        results = mp.Queue()

        # Start streaming
        p = mp.Process(target=camThread,
                       args=(results, frameBuffer, camera_width, camera_height, vidfps, usbcamno),
                       daemon=True)
        p.start()
        processes.append(p)

        # Activation of inferencer
        for process_num in range(core_num):
            p = mp.Process(target=inferencer,
                           args=(results, frameBuffer, model, camera_width, camera_height, process_num, threads_num),
                           daemon=True)
            p.start()
            processes.append(p)

        while True:
            sleep(1)

    finally:
        for p in range(len(processes)):
            processes[p].terminate()
