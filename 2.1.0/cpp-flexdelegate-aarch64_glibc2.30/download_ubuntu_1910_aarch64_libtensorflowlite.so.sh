#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1D2o_BXU7PexYrglqFwhU_GUXDu8ZW7Fp" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1D2o_BXU7PexYrglqFwhU_GUXDu8ZW7Fp" -o libtensorflowlite.so

echo Download finished.
