#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1Xif9TdaZ9m-6tRkFI6eXt0u9xPuYBORm" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1Xif9TdaZ9m-6tRkFI6eXt0u9xPuYBORm" -o tflite_runtime-2.8.0-cp38-none-linux_aarch64.whl

echo Download finished.
