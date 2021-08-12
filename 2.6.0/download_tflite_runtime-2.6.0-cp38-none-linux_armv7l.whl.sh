#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1Q5NWrZDDlsi7b8UJOdpFAAkkdE53TemP" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1Q5NWrZDDlsi7b8UJOdpFAAkkdE53TemP" -o tflite_runtime-2.6.0-cp38-none-linux_armv7l.whl

echo Download finished.
