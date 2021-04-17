#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1LcxeYlCw0UF8vxP6T2aW0g4MWVaAbxWj" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1LcxeYlCw0UF8vxP6T2aW0g4MWVaAbxWj" -o tflite_runtime-2.5.0rc1-cp38-none-linux_armv7l.whl

echo Download finished.
