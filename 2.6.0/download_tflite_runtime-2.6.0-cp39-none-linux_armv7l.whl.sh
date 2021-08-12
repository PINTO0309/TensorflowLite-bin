#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=125ipZr8M66YF0_gXSONpJZoB5XXnf9jz" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=125ipZr8M66YF0_gXSONpJZoB5XXnf9jz" -o tflite_runtime-2.6.0-cp39-none-linux_armv7l.whl

echo Download finished.
