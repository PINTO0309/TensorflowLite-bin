#!/bin/bash

TFVER=2.15.0.post1
curl -OL https://github.com/PINTO0309/TensorflowLite-bin/releases/download/v${TFVER}/tflite_runtime-${TFVER/-/}-cp311-none-linux_aarch64.whl

echo Download finished.
