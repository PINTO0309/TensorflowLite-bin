#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=15itzwwCN7HLZeM542C1Gfr-HoJntlD4n" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=15itzwwCN7HLZeM542C1Gfr-HoJntlD4n" -o tflite_runtime-2.5.0-cp37-none-linux_armv7l.whl

echo Download finished.
