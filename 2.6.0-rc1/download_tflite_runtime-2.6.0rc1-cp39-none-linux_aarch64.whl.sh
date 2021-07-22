#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1lBo9Ou5UdGWqawjWM25gXhzoVuREJVpm" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1lBo9Ou5UdGWqawjWM25gXhzoVuREJVpm" -o tflite_runtime-2.6.0rc1-cp39-none-linux_aarch64.whl

echo Download finished.
