#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1Z5PdWC28bh04F-NQwC8zx1JvUtPpE_nT" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1Z5PdWC28bh04F-NQwC8zx1JvUtPpE_nT" -o tflite_runtime-2.7.0-cp37-none-linux_armv7l.whl

echo Download finished.
