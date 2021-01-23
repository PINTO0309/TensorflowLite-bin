#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1fZZYSgB8X9f-AAzfUJ60jdlgl6OXWQii" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1fZZYSgB8X9f-AAzfUJ60jdlgl6OXWQii" -o tflite_runtime-2.4.0-py3-none-linux_armv7l.whl

echo Download finished.
