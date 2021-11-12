#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1KDzvJEeTM6u5onA9EgtW_YW1DRgnP-Wu" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1KDzvJEeTM6u5onA9EgtW_YW1DRgnP-Wu" -o tflite_runtime-2.7.0-cp39-none-linux_armv7l.whl

echo Download finished.
