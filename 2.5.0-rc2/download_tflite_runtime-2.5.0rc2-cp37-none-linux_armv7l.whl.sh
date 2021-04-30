#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1urtaraaPjnozaUKDSiCyBNUmw1T8rguM" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1urtaraaPjnozaUKDSiCyBNUmw1T8rguM" -o tflite_runtime-2.5.0rc2-cp37-none-linux_armv7l.whl

echo Download finished.
