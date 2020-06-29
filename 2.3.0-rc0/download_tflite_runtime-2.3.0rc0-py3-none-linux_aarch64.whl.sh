#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=18WoX3HJUzAdV08yq7yeoCyDpOxmIzsk2" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=18WoX3HJUzAdV08yq7yeoCyDpOxmIzsk2" -o tflite_runtime-2.3.0rc0-py3-none-linux_aarch64.whl

echo Download finished.
