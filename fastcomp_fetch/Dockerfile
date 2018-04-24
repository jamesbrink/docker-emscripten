ARG FROM_IMAGE="jamesbrink/emscripten_z3"

FROM ${FROM_IMAGE}

# Build Stage ARGs
ARG SDK_VERSION="1.37.37"
ARG CPU_CORES="4"

RUN set -xe; \
    git clone https://github.com/kripken/emscripten-fastcomp; \
    cd emscripten-fastcomp; \
    git clone https://github.com/kripken/emscripten-fastcomp-clang tools/clang;

RUN set -xe; \
    cd /build/emscripten-fastcomp; \
    mkdir build; \
    git checkout ${SDK_VERSION}; \
    cd tools/clang; \
    git checkout ${SDK_VERSION}; \
    cd /build/emscripten-fastcomp/build; \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="X86;JSBackend" -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF -DCLANG_INCLUDE_TESTS=OFF;


