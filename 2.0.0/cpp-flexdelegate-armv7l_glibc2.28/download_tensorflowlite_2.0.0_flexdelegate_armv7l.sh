#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1zKc06oMkCdV1fK2o5B3HKWSNua3E_wAg" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1zKc06oMkCdV1fK2o5B3HKWSNua3E_wAg" -o libtensorflowlite.so
echo Download finished.
