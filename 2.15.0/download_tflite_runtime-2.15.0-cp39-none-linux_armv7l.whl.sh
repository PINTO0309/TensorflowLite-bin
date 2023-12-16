#!/bin/bash

TFVER=2.15.0.post1
curl -OL https://github.com/PINTO0309/TensorflowLite-bin/releases/download/v${TFVER}/tflite_runtime-${TFVER/-/}-cp39-none-linux_armv7l.whl

echo Download finished.
