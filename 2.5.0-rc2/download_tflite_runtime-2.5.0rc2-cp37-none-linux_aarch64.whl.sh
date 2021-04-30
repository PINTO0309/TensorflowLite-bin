#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1MPhLf3FPgigCQoX3PK9LFDSks2Vh2wov" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1MPhLf3FPgigCQoX3PK9LFDSks2Vh2wov" -o tflite_runtime-2.5.0rc2-cp37-none-linux_aarch64.whl

echo Download finished.
