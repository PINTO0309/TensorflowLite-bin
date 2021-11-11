#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1mSv2tccMKAUEygk29V4Yrw_L1IU32NjP" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1mSv2tccMKAUEygk29V4Yrw_L1IU32NjP" -o tflite_runtime-2.7.0-cp38-none-linux_aarch64.whl

echo Download finished.
