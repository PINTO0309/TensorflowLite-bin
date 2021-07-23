#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1eoQ4pw3MRG7TbJ1jvL174sdgmacvUpvo" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1eoQ4pw3MRG7TbJ1jvL174sdgmacvUpvo" -o tflite_runtime-2.6.0rc1-cp38-none-linux_armv7l.whl

echo Download finished.
