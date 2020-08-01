#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1Pi5xKtfmTt-wm6R28RWNjnyH10Ce1qWr" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1Pi5xKtfmTt-wm6R28RWNjnyH10Ce1qWr" -o tflite_runtime-2.3.0-py3-none-any.whl

echo Download finished.
