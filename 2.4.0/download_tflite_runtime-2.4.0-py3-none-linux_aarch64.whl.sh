#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=18GkcYrthUUhukWYuRO_S5ns5mJ9kaiG0" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=18GkcYrthUUhukWYuRO_S5ns5mJ9kaiG0" -o tflite_runtime-2.4.0-py3-none-linux_aarch64.whl

echo Download finished.
