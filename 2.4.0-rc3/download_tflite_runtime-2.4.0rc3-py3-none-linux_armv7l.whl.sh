#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=16v7eD7xeLodHtU__jkRoVI4R1DGS5XtP" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=16v7eD7xeLodHtU__jkRoVI4R1DGS5XtP" -o tflite_runtime-2.4.0rc3-py3-none-linux_armv7l.whl

echo Download finished.
