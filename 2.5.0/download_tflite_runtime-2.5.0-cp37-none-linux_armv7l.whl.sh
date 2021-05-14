#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1ciQrJYXVd2yb9D2i-f6ktDX1FKWeeg0M" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1ciQrJYXVd2yb9D2i-f6ktDX1FKWeeg0M" -o tflite_runtime-2.5.0-cp37-none-linux_armv7l.whl

echo Download finished.
