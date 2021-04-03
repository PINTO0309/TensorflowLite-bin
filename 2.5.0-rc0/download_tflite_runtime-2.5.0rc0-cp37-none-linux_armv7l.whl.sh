#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1nhbLPtL-wzxUbEL_6-cpIgLrvw9ifLRh" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1nhbLPtL-wzxUbEL_6-cpIgLrvw9ifLRh" -o tflite_runtime-2.5.0rc0-cp37-none-linux_armv7l.whl

echo Download finished.
