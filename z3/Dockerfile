ARG FROM_IMAGE="jamesbrink/emscripten_builder"

FROM ${FROM_IMAGE}

# Build Stage ARGs
ARG Z3_VERSION="z3-4.6.0"
ARG CPU_CORES="4"

RUN set -xe; \
    git clone https://github.com/Z3Prover/z3.git;

RUN set -xe; \
    cd z3; \
    git checkout ${Z3_VERSION}; \
    CXX=clang++ CC=clang python scripts/mk_make.py --prefix=/usr/local/z3;

RUN set -xe; \
    cd z3/build; \
    make -j${CPU_CORES}; \
    make install;