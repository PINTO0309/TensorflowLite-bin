#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1RKpx55pWZUg0d3l83-dnAoJGqb1GZx01" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1RKpx55pWZUg0d3l83-dnAoJGqb1GZx01" -o tflite_runtime-2.4.0rc1-py3-none-linux_armv7l.whl

echo Download finished.
