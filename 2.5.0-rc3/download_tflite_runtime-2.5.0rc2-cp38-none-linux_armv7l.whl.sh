#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=18qccamitnE4G3TkJHPM3AK6inl_bhPbY" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=18qccamitnE4G3TkJHPM3AK6inl_bhPbY" -o tflite_runtime-2.5.0rc3-cp38-none-linux_armv7l.whl

echo Download finished.
