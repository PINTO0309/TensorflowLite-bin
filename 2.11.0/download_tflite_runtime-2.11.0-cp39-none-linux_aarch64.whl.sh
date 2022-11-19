#!/bin/bash

TFVER=2.11.0
curl -OL https://github.com/PINTO0309/TensorflowLite-bin/releases/download/v${TFVER}/tflite_runtime-${TFVER/-/}-cp39-none-linux_aarch64.whl

echo Download finished.
