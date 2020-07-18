#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1PzK0_gJ9lOUPG7iNkztZUzqEMm837H5J" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1PzK0_gJ9lOUPG7iNkztZUzqEMm837H5J" -o tflite_runtime-2.3.0rc2-py3-none-linux_armv7l.whl

echo Download finished.
