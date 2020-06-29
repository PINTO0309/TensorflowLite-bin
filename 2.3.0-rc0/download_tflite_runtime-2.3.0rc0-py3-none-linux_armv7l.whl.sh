#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=17edK6aEzUKYSzhOMYmJpxBZpDs-dSaE6" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=17edK6aEzUKYSzhOMYmJpxBZpDs-dSaE6" -o tflite_runtime-2.3.0rc0-py3-none-linux_armv7l.whl

echo Download finished.
