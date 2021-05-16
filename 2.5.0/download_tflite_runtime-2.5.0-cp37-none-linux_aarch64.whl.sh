#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1FvtLZSZFQmV5Ars8BBYFnZIX4X7jg1lA" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1FvtLZSZFQmV5Ars8BBYFnZIX4X7jg1lA" -o tflite_runtime-2.5.0-cp37-none-linux_aarch64.whl

echo Download finished.
