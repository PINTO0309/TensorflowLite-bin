#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1_gYv7CA-AQaDxzuRC6oymExYB52p-rDd" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1_gYv7CA-AQaDxzuRC6oymExYB52p-rDd" -o libtensorflowlite.so
echo Download finished.
