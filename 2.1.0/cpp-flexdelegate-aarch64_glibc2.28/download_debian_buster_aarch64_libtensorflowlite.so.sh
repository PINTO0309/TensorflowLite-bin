#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1NSeuTEtq9wuWUyZFfYVbWMDFWQ4ZNubp" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1NSeuTEtq9wuWUyZFfYVbWMDFWQ4ZNubp" -o libtensorflowlite.so

echo Download finished.
