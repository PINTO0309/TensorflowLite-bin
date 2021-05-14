#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1p1jS6VD_AxYhq_x0KDitS6c67y6lO9QM" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1p1jS6VD_AxYhq_x0KDitS6c67y6lO9QM" -o tflite_runtime-2.5.0-cp38-none-linux_aarch64.whl

echo Download finished.
