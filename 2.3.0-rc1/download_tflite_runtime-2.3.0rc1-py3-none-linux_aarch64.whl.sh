#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1dWNIvUdqD1Y2qQJx0xE0tvI_V-izIv3B" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1dWNIvUdqD1Y2qQJx0xE0tvI_V-izIv3B" -o tflite_runtime-2.3.0rc1-py3-none-linux_aarch64.whl

echo Download finished.
