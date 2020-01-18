#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1InUchwSZa3RTTfDwZU-6kMxgfkInUaZ1" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1InUchwSZa3RTTfDwZU-6kMxgfkInUaZ1" -o libtensorflowlite.so

echo Download finished.
