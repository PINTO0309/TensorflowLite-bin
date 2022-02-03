#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1iXq9PLU1_bHyczaSfOy--IsimdBJpP4w" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1iXq9PLU1_bHyczaSfOy--IsimdBJpP4w" -o tflite_runtime-2.8.0-cp37-none-linux_aarch64.whl

echo Download finished.
