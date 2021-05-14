#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1BHkEgPA762UhsQ-NK63HuGh9mPi--mgB" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1BHkEgPA762UhsQ-NK63HuGh9mPi--mgB" -o tflite_runtime-2.5.0-cp37-none-linux_aarch64.whl

echo Download finished.
