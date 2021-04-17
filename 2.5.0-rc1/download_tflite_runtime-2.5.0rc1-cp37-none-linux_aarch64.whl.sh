#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1nooXpZMoXNo45XqgY6YEsbKid5w1R8dm" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1nooXpZMoXNo45XqgY6YEsbKid5w1R8dm" -o tflite_runtime-2.5.0rc1-cp37-none-linux_aarch64.whl

echo Download finished.
