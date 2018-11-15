# TensorflowLite-bin
Prebuilt binary for TensorflowLite's standalone installer. For RaspberryPi.  
Here is the Tensorflow's official **[README](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/tools/pip_package)**.

**＜WARNING!!＞　It does not seem to work properly as of November 15, 2018.** 

# Usage
**Python2.7**  
```
$ sudo apt install swig libjpeg-dev zlib1g-dev python3-dev python3-numpy
$ wget https://github.com/PINTO0309/TensorflowLite-bin/raw/master/1.12.0rc0/tflite_runtime-1.12.0rc0-cp27-cp27mu-linux_armv7l.whl
$ sudo pip2 install --upgrade tflite_runtime-1.12.0rc0-cp27-cp27mu-linux_armv7l.whl
```
**Python3.5**  
```
$ sudo apt install swig libjpeg-dev zlib1g-dev python3-dev python3-numpy
$ wget https://github.com/PINTO0309/TensorflowLite-bin/raw/master/1.12.0rc0/tflite_runtime-1.12.0rc0-cp35-cp35m-linux_armv7l.whl
$ sudo pip3 install --upgrade tflite_runtime-1.12.0rc0-cp35-cp35m-linux_armv7l.whl
```

# Note
Unlike tensorflow this will be installed to a tflite_runtime namespace.  
You can then use the Tensorflow Lite interpreter as.  
```python
import tflite_runtime as tflr
interpreter = tflr.lite.Interpreter(model_path="foo.tflite")
```
