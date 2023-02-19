#!/bin/bash

TFVER=2.12.0-rc0
curl -OL https://github.com/PINTO0309/TensorflowLite-bin/releases/download/v${TFVER}/tflite_runtime-${TFVER/-/}-cp38-none-linux_armv7l.whl

echo Download finished.
