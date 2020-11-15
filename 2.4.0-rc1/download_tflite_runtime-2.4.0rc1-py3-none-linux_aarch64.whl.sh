#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1TO5bWISQFtmjfEc3RzH_vsekiWYsTubV" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1TO5bWISQFtmjfEc3RzH_vsekiWYsTubV" -o tflite_runtime-2.4.0rc1-py3-none-linux_aarch64.whl

echo Download finished.
