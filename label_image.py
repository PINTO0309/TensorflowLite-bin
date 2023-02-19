import argparse
import numpy as np
import time

from PIL import Image

from tflite_runtime.interpreter import Interpreter

def load_labels(filename):
  my_labels = []
  input_file = open(filename, 'r')
  for l in input_file:
    my_labels.append(l.strip())
  return my_labels
if __name__ == "__main__":
  floating_model = False
  parser = argparse.ArgumentParser()
  parser.add_argument("-i", "--image", type=str, default="grace_hopper.bmp", help="image to be classified")
  parser.add_argument("-m", "--model_file", type=str, default="mobilenet_v1_1.0_224_quant.tflite", help=".tflite model to be executed")
  parser.add_argument("-l", "--label_file", type=str, default="labels.txt", help="name of file containing labels")
  parser.add_argument("--input_mean", type=float,default=127.5, help="input_mean")
  parser.add_argument("--input_std", type=float, default=127.5,  help="input standard deviation")
  parser.add_argument("--num_threads", type=int, default=4, help="number of threads")
  args = parser.parse_args()

  interpreter = Interpreter(
    model_path=args.model_file,
    num_threads=args.num_threads,
  )
  try:
    interpreter.allocate_tensors()
  except:
    pass
  input_details = interpreter.get_input_details()
  output_details = interpreter.get_output_details()
  # check the type of the input tensor
  if input_details[0]['dtype'] == np.float32:
    floating_model = True
  # NxHxWxC, H:1, W:2
  height = input_details[0]['shape'][1]
  width = input_details[0]['shape'][2]
  img = Image.open(args.image)
  img = img.resize((width, height))
  # add N dim
  input_data = np.expand_dims(img, axis=0)
  if floating_model:
    input_data = (np.float32(input_data) - args.input_mean) / args.input_std
  interpreter.set_tensor(input_details[0]['index'], input_data)

  start_time = time.time()
  interpreter.invoke()
  stop_time = time.time()

  output_data = interpreter.get_tensor(output_details[0]['index'])
  results = np.squeeze(output_data)
  top_k = results.argsort()[-5:][::-1]
  labels = load_labels(args.label_file)
  for i in top_k:
    if floating_model:
      print('{0:08.6f}'.format(float(results[i]))+":", labels[i])
    else:
      print('{0:08.6f}'.format(float(results[i]/255.0))+":", labels[i])

  print("time: ", stop_time - start_time)
