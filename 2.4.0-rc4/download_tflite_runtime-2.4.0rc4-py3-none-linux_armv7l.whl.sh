#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1N4gOnuwNUKYM_0qoHZSKx4yVbKLtS-DV" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1N4gOnuwNUKYM_0qoHZSKx4yVbKLtS-DV" -o tflite_runtime-2.4.0rc4-py3-none-linux_armv7l.whl

echo Download finished.
