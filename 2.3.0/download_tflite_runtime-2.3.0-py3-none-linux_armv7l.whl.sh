#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1TO0l6zH080WSFU50GJpeMjWhpaofdljn" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1TO0l6zH080WSFU50GJpeMjWhpaofdljn" -o tflite_runtime-2.3.0-py3-none-linux_armv7l.whl

echo Download finished.
