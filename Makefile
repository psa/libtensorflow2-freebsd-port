PORTNAME=	libtensorflow2
DISTVERSIONPREFIX=	v
DISTVERSION=	2.7.0
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
		bazel>=4.0.0:devel/bazel \
		git:devel/git \
		${PYNUMPY}

USES=	cpe python:3.7-3.9,build

CPE_VENDOR=	google

BINARY_ALIAS=	python3=${PYTHON_CMD}
BINARY_ALIAS+=	python=${PYTHON_CMD}

USE_GITHUB=	yes
GH_ACCOUNT=	tensorflow
GH_PROJECT=	tensorflow

CONFLICTS_INSTALL=	libtensorflow1

USE_LDCONFIG=	yes

OPTIONS_DEFINE=	XLA

OPTIONS_RADIO=	VXG
OPTIONS_RADIO_VXG=	AVX AVX2

VXG_DESC=	Vector Processing Extensions

AVX_DESC=	Enable Intel Advanced Vector Extensions (AVX)
AVX2_DESC=	Enable Intel Advanced Vector Extensions 2 (AVX2)

AVX_VARS=	BAZEL_ARGS+="--copt=-mavx --host_copt=-mavx"
AVX2_VARS=	BAZEL_ARGS+="--copt=-mavx --host_copt=-mavx" \
		BAZEL_ARGS+="--copt=-mavx2 --host_copt=-mavx2"

XLA_DESC=	Enable Accelerated Linear Algebra (XLA)
XLA_VARS=	TF_ENABLE_XLA=1
XLA_VARS_OFF=	TF_ENABLE_XLA=0

OPTIONS_DEFAULT_amd64=	AVX
OPTIONS_EXCLUDE_aarch64=	AVX AVX2

BAZEL_ARGS+=	--action_env=PATH=${PATH} \
		--color=no \
		--config=release_base \
		--local_cpu_resources=${MAKE_JOBS_NUMBER} \
		--noshow_loading_progress \
		--noshow_progress \
		--subcommands \
		--verbose_failures \
		--worker_max_instances=${MAKE_JOBS_NUMBER}
BAZEL_OPTS=	--output_user_root=${WRKDIR}/bazel_out
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
