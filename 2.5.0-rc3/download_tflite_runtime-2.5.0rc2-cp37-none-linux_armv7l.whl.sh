#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1L_jAm1U3soa6B9SX0L01mAt2rXfMCmxU" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1L_jAm1U3soa6B9SX0L01mAt2rXfMCmxU" -o tflite_runtime-2.5.0rc3-cp37-none-linux_armv7l.whl

echo Download finished.
