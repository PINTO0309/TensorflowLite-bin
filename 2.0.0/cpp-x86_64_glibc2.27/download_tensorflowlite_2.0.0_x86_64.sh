#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1cmAXrqedkB3alINWhc8n_YVNo4UZ1mBP" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1cmAXrqedkB3alINWhc8n_YVNo4UZ1mBP" -o libtensorflowlite.so
echo Download finished.

