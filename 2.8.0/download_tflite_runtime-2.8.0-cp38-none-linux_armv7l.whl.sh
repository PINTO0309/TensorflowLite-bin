#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1b1fpv8WpKYjM6B8vxdGTDfKhqMHHMySi" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1b1fpv8WpKYjM6B8vxdGTDfKhqMHHMySi" -o tflite_runtime-2.8.0-cp38-none-linux_armv7l.whl

echo Download finished.
