#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1sQq7UMElMw4UwXhYJ0WWMPYG05ef6GAp" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1sQq7UMElMw4UwXhYJ0WWMPYG05ef6GAp" -o tflite_runtime-2.3.0-py3-none-linux_aarch64.whl

echo Download finished.
