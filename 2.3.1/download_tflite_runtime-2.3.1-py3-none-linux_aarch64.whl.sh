#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1VEFZbY9nG2D83C11OgK2KqnXw-FOVAj3" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1VEFZbY9nG2D83C11OgK2KqnXw-FOVAj3" -o tflite_runtime-2.3.1-py3-none-linux_aarch64.whl

echo Download finished.
