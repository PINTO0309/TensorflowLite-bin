#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=111uqIY1Bur1yBEos8I1W83z4wR1MO_ii" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=111uqIY1Bur1yBEos8I1W83z4wR1MO_ii" -o tflite_runtime-2.5.0-cp37-none-linux_aarch64.whl

echo Download finished.
