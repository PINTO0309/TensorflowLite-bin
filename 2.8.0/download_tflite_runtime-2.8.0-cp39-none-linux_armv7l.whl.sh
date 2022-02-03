#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1f5HhI8wpOydlQXS8w8J0T61MZtjVTrRe" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1f5HhI8wpOydlQXS8w8J0T61MZtjVTrRe" -o tflite_runtime-2.8.0-cp39-none-linux_armv7l.whl

echo Download finished.
