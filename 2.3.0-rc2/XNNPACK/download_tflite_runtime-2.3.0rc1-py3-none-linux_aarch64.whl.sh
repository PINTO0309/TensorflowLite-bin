#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1j_iQtVfFOlsHSlyYcbIj3k9oe07H4wfE" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1j_iQtVfFOlsHSlyYcbIj3k9oe07H4wfE" -o tflite_runtime-2.3.0rc2-py3-none-linux_aarch64.whl

echo Download finished.
