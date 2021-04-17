#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1O8fB1nLLXssVaRHg9mGFO97KAyBrtUf0" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1O8fB1nLLXssVaRHg9mGFO97KAyBrtUf0" -o tflite_runtime-2.5.0rc1-cp38-none-linux_aarch64.whl

echo Download finished.
