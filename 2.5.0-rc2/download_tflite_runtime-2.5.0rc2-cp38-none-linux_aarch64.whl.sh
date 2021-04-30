#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1R8cFp--EH8Yu7KfZyBn6mswGG6KWRqL3" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1R8cFp--EH8Yu7KfZyBn6mswGG6KWRqL3" -o tflite_runtime-2.5.0rc2-cp38-none-linux_aarch64.whl

echo Download finished.
