#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1OHqBgV5yCf3JDT3PCt3oiPpt1-NJU0vG" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1OHqBgV5yCf3JDT3PCt3oiPpt1-NJU0vG" -o tflite_runtime-2.6.0rc1-cp38-none-linux_aarch64.whl

echo Download finished.
