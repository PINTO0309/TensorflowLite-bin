#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=11kxTWwkGfjHAY7TW337xS6PmR4MLPKWx" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=11kxTWwkGfjHAY7TW337xS6PmR4MLPKWx" -o tflite_runtime-2.6.0-cp39-none-linux_aarch64.whl

echo Download finished.
