#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1spTTF8tquh90GHoZnfyUkZPBOD6oOrPd" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1spTTF8tquh90GHoZnfyUkZPBOD6oOrPd" -o tflite_runtime-2.6.0-cp37-none-linux_armv7l.whl

echo Download finished.
