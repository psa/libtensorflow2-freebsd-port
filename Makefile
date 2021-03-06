PORTNAME=	libtensorflow2
DISTVERSIONPREFIX=	v
DISTVERSION=	2.9.1
DISTVERSIONSUFFIX=
CATEGORIES=	science

MAINTAINER=	wamuir@gmail.com
COMMENT=	C API for TensorFlow, an open source platform for machine learning

LICENSE=	APACHE20 THIRD_PARTY_TF_C_LICENSES
LICENSE_COMB=	multi
LICENSE_NAME_THIRD_PARTY_TF_C_LICENSES=	Third-Party TensorFlow C Licenses
LICENSE_FILE_APACHE20=	${WRKSRC}/LICENSE
LICENSE_FILE_THIRD_PARTY_TF_C_LICENSES=	${WRKDIR}/THIRD_PARTY_TF_C_LICENSES
LICENSE_PERMS_THIRD_PARTY_TF_C_LICENSES=	dist-mirror dist-sell pkg-mirror pkg-sell auto-accept

ONLY_FOR_ARCHS=	aarch64 amd64

BUILD_DEPENDS=	bash:shells/bash \
		bazel>=4.2.2:devel/bazel \
		git:devel/git \
		${PYNUMPY}

FLAVORS=	default noavx
FLAVOR?=	${FLAVORS:[1]}
noavx_PKGNAMESUFFIX=	-noavx

USES=	cpe python:3.7-3.9,build

CPE_VENDOR=	google

BINARY_ALIAS=	python3=${PYTHON_CMD}
BINARY_ALIAS+=	python=${PYTHON_CMD}

USE_GITHUB=	yes
GH_ACCOUNT=	tensorflow
GH_PROJECT=	tensorflow

GH_TUPLE= \
        bazelbuild:rules_proto:11bf7c25e666dd7ddacbcd4d4c4a9de7a25175f8:bazelbuild_rules_proto_11bf7c25e666dd7ddacbcd4d4c4a9de7a25175f8 \
        bazelbuild:bazel-toolchains:dfc67056200b674accd08d8f9a21e328098c07e2:bazelbuild_bazel_toolchains_dfc67056200b674accd08d8f9a21e328098c07e2 \
        google:XNNPACK:11b2812d64e49bab9b6c489f79067fc94e69db9f:google_XNNPACK_11b2812d64e49bab9b6c489f79067fc94e69db9f \
        Maratyszcza:FXdiv:63058eff77e11aa15bf531df5dd34395ec3017c8:Maratyszcza_FXdiv_63058eff77e11aa15bf531df5dd34395ec3017c8 \
        Maratyszcza:pthreadpool:b8374f80e42010941bda6c85b0e3f1a1bd77a1e0:Maratyszcza_pthreadpool_b8374f80e42010941bda6c85b0e3f1a1bd77a1e0 \
        NVIDIA:cudnn-frontend:73210a930333eaf66b42b01693bce7b70719c354:NVIDIA_cudnn_frontend_73210a930333eaf66b42b01693bce7b70719c354 \
        oneapi-src:oneDNN:v0.21.3:oneapi_src_oneDNN_v0_21_3 \
        oneapi-src:oneDNN:refs/tags/v2.6:oneapi_src_oneDNN_refs_tags_v2_6 \
        oneapi-src:oneDNN:v2.6:oneapi_src_oneDNN_v2_6 \
        ARM-software:ComputeLibrary:v22.02:ARM_software_ComputeLibrary_v22_02 \
        rvagg:rpi-newer-crosstools:eb68350c5c8ec1663b7fe52c742ac4271e3217c5:rvagg_rpi_newer_crosstools_eb68350c5c8ec1663b7fe52c742ac4271e3217c5 \
        hfp:libxsmm:1.16.3:hfp_libxsmm_1_16_3 \
        google:re2:506cfa4bffd060c06ec338ce50ea3468daa6c814:google_re2_506cfa4bffd060c06ec338ce50ea3468daa6c814 \
        google:crc32c:1.0.6:google_crc32c_1_0_6 \
        googleapis:google-cloud-cpp:v1.17.1:googleapis_google_cloud_cpp_v1_17_1 \
        GoogleCloudPlatform:tensorflow-gcp-tools:2643d8caeba6ca2a6a0b46bb123953cb95b7e7d5:GoogleCloudPlatform_tensorflow_gcp_tools_2643d8caeba6ca2a6a0b46bb123953cb95b7e7d5 \
        googleapis:googleapis:541b1ded4abadcc38e8178680b0677f65594ea6f:googleapis_googleapis_541b1ded4abadcc38e8178680b0677f65594ea6f \
        glennrp:libpng:v1.6.37:glennrp_libpng_v1_6_37 \
        abseil:abseil-py:refs/tags/v1.0.0:abseil_abseil_py_refs_tags_v1_0_0 \
        protocolbuffers:protobuf:v3.9.2:protocolbuffers_protobuf_v3_9_2 \
        google:nsync:1.22.0:google_nsync_1_22_0 \
        google:googletest:e2c06aa2497e330bab1c1a03d02f7c5096eb5b0b:google_googletest_e2c06aa2497e330bab1c1a03d02f7c5096eb5b0b \
        gflags:gflags:v2.2.1:gflags_gflags_v2_2_1 \
        grpc:grpc:b54a5b338637f92bfcf4b0bc05e0f57a5fd8fadd:grpc_grpc_b54a5b338637f92bfcf4b0bc05e0f57a5fd8fadd \
        antirez:linenoise:c894b9e59f02203dbe4e2be657572cf88c4230c3:antirez_linenoise_c894b9e59f02203dbe4e2be657572cf88c4230c3 \
        LMDB:lmdb:refs/tags/LMDB_0.9.29:LMDB_lmdb_refs_tags_LMDB_0_9_29 \
        open-source-parsers:jsoncpp:1.9.5:open_source_parsers_jsoncpp_1_9_5 \
        google:boringssl:80ca9f9f6ece29ab132cce4cf807a9465a18cfac:google_boringssl_80ca9f9f6ece29ab132cce4cf807a9465a18cfac \
        petewarden:OouraFFT:v1.0:petewarden_OouraFFT_v1_0 \
        google:snappy:1.1.8:google_snappy_1_1_8 \
        nvidia:nccl:v2.8.3-1:nvidia_nccl_v2_8_3_1 \
        google:pprof:c0fb62ec88c411cc91194465e54db2632845b650:google_pprof_c0fb62ec88c411cc91194465e54db2632845b650 \
        NVlabs:cub:1.9.9:NVlabs_cub_1_9_9 \
        cython:cython:0.29.21:cython_cython_0_29_21 \
        intel:ARM_NEON_2_x86_SSE:1200fe90bb174a6224a525ee60148671a786a71f:intel_ARM_NEON_2_x86_SSE_1200fe90bb174a6224a525ee60148671a786a71f \
        google:double-conversion:refs/tags/v3.1.7:google_double_conversion_refs_tags_v3_1_7 \
        bazelbuild:rules_android:v0.1.1:bazelbuild_rules_android_v0_1_1 \
        apple:swift-protobuf:1.18.0:apple_swift_protobuf_1_18_0 \
        google:xctestrunner:refs/tags/0.2.15:google_xctestrunner_refs_tags_0_2_15 \
        nlohmann:json:v3.4.0:nlohmann_json_v3_4_0 \
        pybind:pybind11:v2.8.1:pybind_pybind11_v2_8_1 \
        GrahamDumpleton:wrapt:1.11.1:GrahamDumpleton_wrapt_1_11_1 \
        apple:coremltools:3.3:apple_coremltools_3_3 \
        bazelbuild:rules_closure:308b05b2419edb5c8ee0471b67a40403df940149:bazelbuild_rules_closure_308b05b2419edb5c8ee0471b67a40403df940149 \
        llvm:llvm-project:llvmorg-10.0.1:llvm_llvm_project_llvmorg_10_0_1 \
        bazelbuild:rules_python:0.0.1:bazelbuild_rules_python_0_0_1 \
        bazelbuild:rules_apple:0.33.0:bazelbuild_rules_apple_0_33_0 \
        bazelbuild:rules_swift:0.25.0:bazelbuild_rules_swift_0_25_0 \
        bazelbuild:apple_support:0.12.1:bazelbuild_apple_support_0_12_1 \
        bazelbuild:bazel-skylib:1.0.3:bazelbuild_bazel_skylib_1_0_3 \
        bazelbuild:rules_pkg:0.2.5:bazelbuild_rules_pkg_0_2_5 \
        tensorflow:runtime:093ed77f7d50f75b376f40a71ea86e08cedb8b80:tensorflow_runtime_093ed77f7d50f75b376f40a71ea86e08cedb8b80

CONFLICTS_INSTALL=	libtensorflow1 ${FLAVORS:N${FLAVOR}:S/^/libtensorflow2-/}

USE_LDCONFIG=	yes

OPTIONS_DEFINE=	XLA
OPTIONS_DEFAULT_amd64=	AVX

OPTIONS_SINGLE=                 CPUFEATURE
OPTIONS_SINGLE_CPUFEATURE=      AVX AVX2 NOAVX
.if ${FLAVOR:U} == noavx
OPTIONS_EXCLUDE:=       ${OPTIONS_SINGLE_CPUFEATURE}
.endif
OPTIONS_EXCLUDE_aarch64=	AVX AVX2 NOAVX

CPUFEATURE_DESC=	Vector Processing Extensions

AVX_DESC=	Enable Intel Advanced Vector Extensions (AVX)
AVX2_DESC=	Enable Intel Advanced Vector Extensions 2 (AVX2)

AVX_VARS=	BAZEL_ARGS+="--copt=-mavx --host_copt=-mavx"
AVX2_VARS=	BAZEL_ARGS+="--copt=-mavx --host_copt=-mavx" \
		BAZEL_ARGS+="--copt=-mavx2 --host_copt=-mavx2"
NOAVX_VARS=     BAZEL_ARGS=""

XLA_DESC=	Enable Accelerated Linear Algebra (XLA)
XLA_VARS=	TF_ENABLE_XLA=1
XLA_VARS_OFF=	TF_ENABLE_XLA=0

BAZEL_ARGS+=	--action_env=PATH=${PATH} \
		--color=no \
		--config=release_base \
		--local_cpu_resources=${MAKE_JOBS_NUMBER} \
		--noshow_loading_progress \
		--noshow_progress \
		--subcommands \
		--verbose_failures \
		--worker_max_instances=${MAKE_JOBS_NUMBER}
# Batch is sub-optimal but the current version of Bazel doesn't find the
# network and it goes into a restart loop
BAZEL_OPTS=	--output_user_root=${WRKDIR}/bazel_out --batch
CC?=	clang

.include <bsd.port.pre.mk>

.if ${ARCH} == "aarch64"
BAZEL_ARGS+=	--define=tensorflow_mkldnn_contraction_kernel=0
.endif

post-extract:
	# THIRD_PARTY_TF_C_LICENSES is generated as a Bazel build target (see
	# //tensorflow/tools/lib_package:clicenses) and the empty file written
	# here will be overwritten. Creation of this file is to satisfy checks.
	@${TOUCH} ${WRKDIR}/THIRD_PARTY_TF_C_LICENSES

do-configure:
	@cd ${WRKSRC} && ${SETENV} \
		CC_OPT_FLAGS="-I${LOCALBASE}/include" \
		PREFIX="${LOCALBASE}" \
		PYTHON_BIN_PATH=${PYTHON_CMD} \
		PYTHON_LIB_PATH="${PYTHON_SITELIBDIR}" \
		TF_CONFIGURE_IOS=0 \
		TF_DOWNLOAD_CLANG=0 \
		TF_ENABLE_XLA=${TF_ENABLE_XLA} \
		TF_IGNORE_MAX_BAZEL_VERSION=0 \
		TF_NEED_CUDA=0 \
		TF_NEED_ROCM=0 \
		TF_NEED_TENSORRT=0 \
		TF_SET_ANDROID_WORKSPACE=0 \
		${LOCALBASE}/bin/bash ./configure

do-build:
	@cd ${WRKSRC} && ${LOCALBASE}/bin/bazel ${BAZEL_OPTS} \
		build ${BAZEL_ARGS} \
		//tensorflow/tools/lib_package:clicenses_generate \
		//tensorflow/tools/lib_package:libtensorflow.tar.gz

do-test:
	@cd ${WRKSRC} && ${LOCALBASE}/bin/bazel ${BAZEL_OPTS} \
		test ${BAZEL_ARGS} \
		--test_env=CC=${CC} \
		--test_output=errors \
		--test_verbose_timeout_warnings \
		//tensorflow/tools/lib_package:libtensorflow_test

pre-install:
	@${CP} \
		${WRKSRC}/bazel-bin/tensorflow/tools/lib_package/THIRD_PARTY_TF_C_LICENSES \
		${WRKDIR}/THIRD_PARTY_TF_C_LICENSES
	@${MKDIR} ${WRKDIR}/lib_package
	@tar xz -C ${WRKDIR}/lib_package \
		-f ${WRKSRC}/bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz
	${MKDIR} ${STAGEDIR}${PREFIX}/include/tensorflow/c/eager
	${MKDIR} ${STAGEDIR}${PREFIX}/include/tensorflow/core/platform

do-install:
.for f in c_api.h c_api_experimental.h c_api_macros.h tensor_interface.h \
	tf_attrtype.h tf_datatype.h tf_file_statistics.h tf_status.h \
	tf_tensor.h tf_tstring.h \
	eager/c_api.h eager/c_api_experimental.h eager/dlpack.h
	${INSTALL_DATA} ${WRKDIR}/lib_package/include/tensorflow/c/${f} \
	  ${STAGEDIR}${PREFIX}/include/tensorflow/c/${f}
.endfor
.for d in ctstring.h ctstring_internal.h
	${INSTALL_DATA} \
	  ${WRKDIR}/lib_package/include/tensorflow/core/platform/${d} \
	  ${STAGEDIR}${PREFIX}/include/tensorflow/core/platform/${d}
.endfor
.for l in libtensorflow libtensorflow_framework
	${INSTALL_PROGRAM} ${WRKDIR}/lib_package/lib/${l}.so.${DISTVERSION} \
	  ${STAGEDIR}${PREFIX}/lib/${l}.so.${DISTVERSION}
	@${RLN} ${STAGEDIR}${PREFIX}/lib/${l}.so.${DISTVERSION} \
	  ${STAGEDIR}${PREFIX}/lib/${l}.so.2
	@${RLN} ${STAGEDIR}${PREFIX}/lib/${l}.so.2 \
	  ${STAGEDIR}${PREFIX}/lib/${l}.so
.endfor

.include <bsd.port.post.mk>
