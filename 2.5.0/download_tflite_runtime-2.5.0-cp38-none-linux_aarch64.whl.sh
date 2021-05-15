#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=14WcBuscMsYs-VZujD08Y4e1jXJPP1IXg" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=14WcBuscMsYs-VZujD08Y4e1jXJPP1IXg" -o tflite_runtime-2.5.0-cp38-none-linux_aarch64.whl

echo Download finished.
