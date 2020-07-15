#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1OG1RZrDmxCpRsvh66nAlkAgzvA_d3jEm" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1OG1RZrDmxCpRsvh66nAlkAgzvA_d3jEm" -o tflite_runtime-2.3.0rc1-py3-none-linux_aarch64.whl

echo Download finished.
