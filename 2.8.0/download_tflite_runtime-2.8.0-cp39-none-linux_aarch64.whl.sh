#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=13pl2U4Yd_IGoyxc4FVd4Iwz-i5v-k38Q" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=13pl2U4Yd_IGoyxc4FVd4Iwz-i5v-k38Q" -o tflite_runtime-2.8.0-cp39-none-linux_aarch64.whl

echo Download finished.
