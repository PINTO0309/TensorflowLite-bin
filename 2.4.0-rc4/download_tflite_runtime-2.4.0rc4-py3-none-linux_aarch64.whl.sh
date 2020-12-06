#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=11gLW6mFcMX8cQjNPJhxFrrZ-4Zyzqzbg" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=11gLW6mFcMX8cQjNPJhxFrrZ-4Zyzqzbg" -o tflite_runtime-2.4.0rc4-py3-none-linux_aarch64.whl

echo Download finished.
