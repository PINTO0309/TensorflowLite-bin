#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=12F2q4VaFhNlS2jArl-WpVwtUr3pkVXyH" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=12F2q4VaFhNlS2jArl-WpVwtUr3pkVXyH" -o tflite_runtime-2.7.0-cp39-none-linux_aarch64.whl

echo Download finished.
