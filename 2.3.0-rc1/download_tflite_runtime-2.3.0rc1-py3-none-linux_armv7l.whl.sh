#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1YbiygQ2XliCE18LfPgPeAqKIAXkephFJ" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1YbiygQ2XliCE18LfPgPeAqKIAXkephFJ" -o tflite_runtime-2.3.0rc1-py3-none-linux_armv7l.whl

echo Download finished.
