#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=19c7psJ9JSwivM2EQezM8UacBea-WY6_R" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=19c7psJ9JSwivM2EQezM8UacBea-WY6_R" -o tflite_runtime-2.5.0rc3-cp37-none-linux_aarch64.whl

echo Download finished.
