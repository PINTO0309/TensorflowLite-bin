#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1_1eC0NCXnoVeNhxoSVHtS_YsKxfwHm_T" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1_1eC0NCXnoVeNhxoSVHtS_YsKxfwHm_T" -o tflite_runtime-2.6.0rc1-cp37-none-linux_armv7l.whl

echo Download finished.
