#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1bOK1s2nS7V9eXcfHq9LYl3b6xPF-Sc7D" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1bOK1s2nS7V9eXcfHq9LYl3b6xPF-Sc7D" -o tflite_runtime-2.4.0-py3-none-linux_aarch64.whl

echo Download finished.
