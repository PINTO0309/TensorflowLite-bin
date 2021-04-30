#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=14nC9TEwxC5e9koz8_JweCImj8JzFj3v3" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=14nC9TEwxC5e9koz8_JweCImj8JzFj3v3" -o tflite_runtime-2.5.0rc2-cp38-none-linux_armv7l.whl

echo Download finished.
