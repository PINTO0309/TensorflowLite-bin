# TensorflowLite-bin
Prebuilt binary for TensorflowLite's standalone installer. For RaspberryPi.  
Here is the Tensorflow's official **[README](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/tools/pip_package)**.

# Usage
**Python3.7**  
```
$ sudo apt install swig libjpeg-dev zlib1g-dev python3-dev python3-numpy unzip
$ wget https://github.com/PINTO0309/TensorflowLite-bin/raw/master/1.14.0/tflite_runtime-1.14.0-cp37-cp37m-linux_armv7l.whl
$ sudo pip3 install --upgrade tflite_runtime-1.14.0-cp37-cp37m-linux_armv7l.whl
```

# Note
Unlike tensorflow this will be installed to a tflite_runtime namespace.  
You can then use the Tensorflow Lite interpreter as.  
```python
import tflite_runtime as tflr
interpreter = tflr.lite.Interpreter(model_path="foo.tflite")
```
