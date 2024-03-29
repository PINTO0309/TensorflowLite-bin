#!/bin/bash

TFVER=2.16.1
curl -OL https://github.com/PINTO0309/TensorflowLite-bin/releases/download/v${TFVER}/tflite_runtime-${TFVER/-/}-cp311-none-linux_armv7l.whl

echo Download finished.