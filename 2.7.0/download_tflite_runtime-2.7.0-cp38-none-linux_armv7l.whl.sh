#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1E79c2jJ5rmAd-ccSZOwJu6pvOObOQl6D" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1E79c2jJ5rmAd-ccSZOwJu6pvOObOQl6D" -o tflite_runtime-2.7.0-cp38-none-linux_armv7l.whl

echo Download finished.
