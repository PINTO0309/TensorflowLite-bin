#!/bin/bash

TFVER=2.12.0
curl -OL https://github.com/PINTO0309/TensorflowLite-bin/releases/download/v${TFVER}/tflite_runtime-${TFVER/-/}-cp38-none-linux_aarch64.whl

echo Download finished.
