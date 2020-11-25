#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1H2CnjyJJSGFCSeEyg-aPAfquN-B-Q1c6" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1H2CnjyJJSGFCSeEyg-aPAfquN-B-Q1c6" -o tflite_runtime-2.4.0rc3-py3-none-linux_aarch64.whl

echo Download finished.
