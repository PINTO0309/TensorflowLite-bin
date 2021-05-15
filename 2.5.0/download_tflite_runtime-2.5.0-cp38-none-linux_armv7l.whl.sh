#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1V6oFhRG73cEBd2GydGbnmY9AW_jOeHZb" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1V6oFhRG73cEBd2GydGbnmY9AW_jOeHZb" -o tflite_runtime-2.5.0-cp38-none-linux_armv7l.whl

echo Download finished.
