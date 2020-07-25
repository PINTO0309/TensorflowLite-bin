#!/bin/bash

curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1boc96D7YifP1uZq8KXP3PoDKN7I5EiJs" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1boc96D7YifP1uZq8KXP3PoDKN7I5EiJs" -o tflite_runtime-2.3.0rc2-py3-none-linux_armv7l.whl

echo Download finished.
