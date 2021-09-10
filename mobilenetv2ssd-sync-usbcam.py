import argparse
#import platform
import sys
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
    def __init__(self, model_path='detect.tflite', num_threads=12):
        try:
            self.interpreter = Interpreter(model_path=model_path, num_threads=num_threads)
        except:
            self.interpreter = tf.lite.Interpreter(model_path=model_path, num_threads=num_threads)
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
                _, im_height, im_width, _ = image.shape
                left, right, top, bottom = [int(z) for z in (xmin * im_width, xmax * im_width, ymin * im_height, ymax * im_height)]
                person_boxes.append([(left, top), (right, bottom), scores[i], LABELS[classes[i]]])
        return person_boxes


    def detect(self, image, threshold=0.1):

        # run model
        self.interpreter.set_tensor(self.input_details[0]['index'], image)
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
    parser.add_argument("--usbcamno", type=int, default=0, help="USB Camera number.")
    parser.add_argument("--camera_type", default="usb_cam", help="set usb_cam or raspi_cam")
    parser.add_argument("--camera_width", type=int, default=640, help="width.")
    parser.add_argument("--camera_height", type=int, default=480, help="height.")
    parser.add_argument("--vidfps", type=int, default=150, help="Frame rate.")
    parser.add_argument("--num_threads", type=int, default=4, help="Threads.")
    args = parser.parse_args()

    model         = args.model
    usbcamno      = args.usbcamno
    camera_type   = args.camera_type
    camera_width  = args.camera_width
    camera_height = args.camera_height
    vidfps        = args.vidfps
    num_threads   = args.num_threads

    if camera_type == "usb_cam":
        cam = cv2.VideoCapture(usbcamno)
        cam.set(cv2.CAP_PROP_FPS, vidfps)
        cam.set(cv2.CAP_PROP_FRAME_WIDTH, camera_width)
        cam.set(cv2.CAP_PROP_FRAME_HEIGHT, camera_height)
        window_name = "USB Camera"
    elif camera_type == "raspi_cam":
        from picamera.array import PiRGBArray
        from picamera import PiCamera
        cam = PiCamera()
        cam.resolution = (camera_width, camera_height)
        stream = PiRGBArray(cam)
        window_name = "Raspi Camera"
    else:
        print('[Error] --camera_type: wrong device')
        parser.print_help()
        sys.exit()
    print(window_name)
    cv2.namedWindow(window_name, cv2.WINDOW_AUTOSIZE)

    detector = ObjectDetectorLite(model, num_threads)

    while True:
        t1 = time.perf_counter()

        if camera_type == 'raspi_cam':
            cam.capture(stream, 'bgr', use_video_port=True)
            color_image = stream.array
            stream.truncate(0)
        else:
            ret, color_image = cam.read()
            if not ret:
              continue

        prepimg = cv2.resize(color_image, (300, 300))
        frames = prepimg.copy()
        prepimg = prepimg[:, :, ::-1].copy()
        prepimg = np.expand_dims(prepimg, axis=0)
        prepimg = prepimg.astype('uint8')
        res = detector.detect(prepimg, 0.4)

        imdraw = overlay_on_image(frames, res, camera_width, camera_height)
        imdraw = cv2.resize(imdraw, (camera_width, camera_height))
        cv2.imshow(window_name, imdraw)

        if cv2.waitKey(1)&0xFF == ord('q'):
            break

        # FPS calculation
        framecount += 1
        if framecount >= 15:
            fps       = "(Playback) {:.1f} FPS".format(time1/15)
            framecount = 0
            detectframecount = 0
            time1 = 0
            time2 = 0
        t2 = time.perf_counter()
        elapsedTime = t2-t1
        time1 += 1/elapsedTime
        time2 += elapsedTime

