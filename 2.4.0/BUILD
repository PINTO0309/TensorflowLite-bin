cc_library(
    name = "builtin_op_kernels",
    srcs = BUILTIN_KERNEL_SRCS + [
        "max_pool_argmax.cc",
        "max_unpooling.cc",
        "transpose_conv_bias.cc",
    ],
    hdrs = [
        "dequantize.h",
        "max_pool_argmax.h",
        "max_unpooling.h",
        "transpose_conv_bias.h",
    ],
    compatible_with = get_compatible_with_portable(),
    copts = tflite_copts() + tf_opts_nortti_if_android() + EXTRA_EIGEN_COPTS,
    visibility = ["//visibility:private"],
    deps = BUILTIN_KERNEL_DEPS + [
        "@ruy//ruy/profiler:instrumentation",
        "//tensorflow/lite/kernels/internal:cppmath",
        "//tensorflow/lite:string",
        "@farmhash_archive//:farmhash",
    ],
)