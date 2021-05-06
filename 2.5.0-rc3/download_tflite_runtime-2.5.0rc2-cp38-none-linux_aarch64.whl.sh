#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1dNuIPXcWX__c1UR70rvMwEXY3E19acQ3" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1dNuIPXcWX__c1UR70rvMwEXY3E19acQ3" -o tflite_runtime-2.5.0rc3-cp38-none-linux_aarch64.whl

echo Download finished.
