#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1kxzStmGqSbPrxXbd6PDTzW9sqyzEVUAs" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1kxzStmGqSbPrxXbd6PDTzW9sqyzEVUAs" -o tflite_runtime-2.3.0rc2-py3-none-linux_aarch64.whl

echo Download finished.
