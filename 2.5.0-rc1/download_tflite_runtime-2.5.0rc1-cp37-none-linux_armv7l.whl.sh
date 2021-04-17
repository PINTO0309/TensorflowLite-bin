#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1Qi841ocSNMIcsYF6-hSJYqT-jr3Jrz3u" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1Qi841ocSNMIcsYF6-hSJYqT-jr3Jrz3u" -o tflite_runtime-2.5.0rc1-cp37-none-linux_armv7l.whl

echo Download finished.
