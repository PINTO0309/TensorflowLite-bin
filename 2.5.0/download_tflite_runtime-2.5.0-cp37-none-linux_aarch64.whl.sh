#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1mnb9DOzNG3kuTeY9z24W00vO2nZS9awE" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1mnb9DOzNG3kuTeY9z24W00vO2nZS9awE" -o tflite_runtime-2.5.0-cp37-none-linux_aarch64.whl

echo Download finished.
