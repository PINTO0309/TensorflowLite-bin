#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=15kbKiyCpY_PPkjCbRcChztujRbBlbazS" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=15kbKiyCpY_PPkjCbRcChztujRbBlbazS" -o tflite_runtime-2.5.0rc0-cp37-none-linux_aarch64.whl

echo Download finished.
