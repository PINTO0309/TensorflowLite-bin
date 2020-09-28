#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1NVidFWHvnvFDXwyExbc2TqY49A-kR1xM" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1NVidFWHvnvFDXwyExbc2TqY49A-kR1xM" -o tflite_runtime-2.3.1-py3-none-linux_armv7l.whl

echo Download finished.
