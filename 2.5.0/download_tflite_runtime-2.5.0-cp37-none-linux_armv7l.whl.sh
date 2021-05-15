#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1zdrasiVoKqj3jZnn60cL-gGHtLV1OktO" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1zdrasiVoKqj3jZnn60cL-gGHtLV1OktO" -o tflite_runtime-2.5.0-cp37-none-linux_armv7l.whl

echo Download finished.
