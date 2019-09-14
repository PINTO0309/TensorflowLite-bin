# TensorflowLite-bin
Prebuilt binary for TensorflowLite's standalone installer. Fast tuning with MultiTread. For RaspberryPi.  
Here is the Tensorflow's official **[README](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/tools/pip_package)**.

The full build package for Tensorflow can be found **[here (Tensorflow-bin)](https://github.com/PINTO0309/Tensorflow-bin.git)**.  

My article. **[Tensorflow Lite v1.14.0 / v1.15.0-rc0 armhf (armv7l) is tuned for MultiThread acceleration and cross-compiled for RaspberryPi on Ubuntu](https://qiita.com/PINTO/items/961010e38aa77fb6269b)**

## Python API packages

|Device|OS|Distribution|Architecture|Python ver|Note|
|:--|:--|:--|:--|:--|:--|
|RaspberryPi3/4|Raspbian/Debian|Stretch|armhf / armv7l|3.5|32bit|
|RaspberryPi3/4|Raspbian/Debian|Buster|armhf / armv7l|3.7|32bit|
|RaspberryPi3/4|Raspbian/Debian|Stretch|aarch64 / armv8|3.5|64bit|
|RaspberryPi3/4|Raspbian/Debian|Buster|aarch64 / armv8|3.7|64bit|

## Usage
**Python3.5 - Stretch**  
```bash
$ sudo apt install swig libjpeg-dev zlib1g-dev python3-dev python3-numpy unzip
$ wget https://github.com/PINTO0309/TensorflowLite-bin/raw/master/1.14.0/tflite_runtime-1.14.0-cp35-cp35m-linux_armv7l.whl
$ sudo pip3 install --upgrade tflite_runtime-1.14.0-cp35-cp35m-linux_armv7l.whl
```
**Python3.7 - Buster**  
```bash
$ sudo apt install swig libjpeg-dev zlib1g-dev python3-dev python3-numpy unzip
$ wget https://github.com/PINTO0309/TensorflowLite-bin/raw/master/1.14.0/tflite_runtime-1.14.0-cp37-cp37m-linux_armv7l.whl
$ sudo pip3 install --upgrade tflite_runtime-1.14.0-cp37-cp37m-linux_armv7l.whl
```

## Note
Unlike tensorflow this will be installed to a tflite_runtime namespace.  
You can then use the Tensorflow Lite interpreter as.  
```python
from tflite_runtime.interpreter import Interpreter
interpreter = Interpreter(model_path="foo.tflite")
```
## Build parameter

```bash
cd tensorflow/tensorflow/lite/tools/pip_package
make BASE_IMAGE=debian:stretch PYTHON=python3 TENSORFLOW_TARGET=rpi BUILD_DEB=y docker-build
make BASE_IMAGE=debian:buster PYTHON=python3 TENSORFLOW_TARGET=rpi BUILD_DEB=y docker-build
make BASE_IMAGE=debian:stretch PYTHON=python3 TENSORFLOW_TARGET=aarch64 BUILD_DEB=y docker-build
make BASE_IMAGE=debian:buster PYTHON=python3 TENSORFLOW_TARGET=aarch64 BUILD_DEB=y docker-build
```
## Operation check 【Classification】
**Sample of MultiThread x4 by Tensorflow Lite [MobileNetV1 / 75ms]**  
![01](media/01.png)  
  
**Sample of MultiThread x4 by Tensorflow Lite [MobileNetV2 / 68ms]**
![02](media/02.png)  

- **Environmental preparation**
```bash
$ cd ~;mkdir test
$ curl https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/lite/examples/label_image/testdata/grace_hopper.bmp > ~/test/grace_hopper.bmp
$ curl https://storage.googleapis.com/download.tensorflow.org/models/mobilenet_v1_1.0_224_frozen.tgz | tar xzv -C ~/test mobilenet_v1_1.0_224/labels.txt
$ mv ~/test/mobilenet_v1_1.0_224/labels.txt ~/test/
$ curl http://download.tensorflow.org/models/mobilenet_v1_2018_02_22/mobilenet_v1_1.0_224_quant.tgz | tar xzv -C ~/test
$ cd ~/test
```
- **label_image.py**
```python
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
  parser.add_argument("-i", "--image", default="/tmp/grace_hopper.bmp", \
    help="image to be classified")
  parser.add_argument("-m", "--model_file", \
    default="/tmp/mobilenet_v1_1.0_224_quant.tflite", \
    help=".tflite model to be executed")
  parser.add_argument("-l", "--label_file", default="/tmp/labels.txt", \
    help="name of file containing labels")
  parser.add_argument("--input_mean", default=127.5, help="input_mean")
  parser.add_argument("--input_std", default=127.5, \
    help="input standard deviation")
  parser.add_argument("--num_threads", default=1, help="number of threads")
  args = parser.parse_args()

  interpreter = Interpreter(model_path=args.model_file)
  interpreter.allocate_tensors()
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

  interpreter.set_num_threads(int(args.num_threads)) #<- Specifies the num of threads assigned to inference
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
```
- **Inference test**
```bash
$ python3 label_image.py \
--num_threads 4 \
--image grace_hopper.bmp \
--model_file mobilenet_v1_1.0_224_quant.tflite \
--label_file labels.txt
```

## Operation check 【ObjectDetection】
**Sample of MultiThread x4 by Tensorflow Lite [MobileNetV1 / 75ms]**  
![03](media/03.png)  
![04](media/04.png)  

## List of quantized models
**https://www.tensorflow.org/lite/guide/hosted_models**  

## Other MobileNetV1 weight files
**https://github.com/tensorflow/models/blob/master/research/slim/nets/mobilenet_v1.md**  

## Other MobileNetV2 weight files
**https://github.com/tensorflow/models/blob/master/research/slim/nets/mobilenet/README.md**  

## Reference
**tflite only python package https://github.com/PINTO0309/Tensorflow-bin/issues/15**  
**Incorrect predictions of Mobilenet_V2 https://github.com/tensorflow/tensorflow/issues/31229#issuecomment-527296093**

