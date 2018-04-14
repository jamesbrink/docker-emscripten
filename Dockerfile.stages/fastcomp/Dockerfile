ARG BUILDER

FROM ${BUILDER}

# Build Stage ARGs
ARG SDK_VERSION
ARG CPU_CORES

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

RUN set -xe; \
    cd /build/emscripten-fastcomp/build; \
    echo "CPU_CORES=${CPU_CORES}"; \
    make -j${CPU_CORES};
    

