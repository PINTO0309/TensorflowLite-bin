#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1WJt_TSy2YA45d5VwbPLwUN6WN1LagePM" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1WJt_TSy2YA45d5VwbPLwUN6WN1LagePM" -o libtensorflowlite.so
echo Download finished.

