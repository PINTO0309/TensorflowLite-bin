#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1-tckHmUvnoE8YXB3nraS5liK5m1KkPXz" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1-tckHmUvnoE8YXB3nraS5liK5m1KkPXz" -o tflite_runtime-2.4.0-py3-none-linux_armv7l.whl

echo Download finished.
