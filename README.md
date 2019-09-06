# TensorflowLite-bin
Prebuilt binary for TensorflowLite's standalone installer. Fast tuning with MultiTread. For RaspberryPi.  
Here is the Tensorflow's official **[README](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/tools/pip_package)**.

## Python API packages

|Device|OS|Distribution|Architecture|Python ver|Note|
|:--|:--|:--|:--|:--|:--|
|RaspberryPi3/4|Raspbian/Debian|Stretch|armhf / armv7l|3.5.3|32bit|
|RaspberryPi3/4|Raspbian/Debian|Buster|armhf / armv7l|3.7.3|32bit|
|RaspberryPi3/4|Raspbian/Debian|Stretch|aarch64 / armv8|3.5.3|64bit|
|RaspberryPi3/4|Raspbian/Debian|Buster|aarch64 / armv8|3.7.3|64bit|

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
## Operation check
**[PINTO0309/Tensorflow-bin - Sample of MultiThread x4 by Tensorflow Lite](https://github.com/PINTO0309/Tensorflow-bin#operation-check)**

## Reference
**tflite only python package https://github.com/PINTO0309/Tensorflow-bin/issues/15**
