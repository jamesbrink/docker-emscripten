ARG FROM_IMAGE="jamesbrink/emscripten_fastcomp_stage3"

FROM ${FROM_IMAGE}

# Build Stage ARGs
ARG SDK_VERSION="1.37.37"
ARG CPU_CORES="4"
ARG BUILD_TIMEOUT=2400

RUN cd /build/emscripten-fastcomp/build; \
    echo "CPU_CORES=${CPU_CORES}"; \
    timeout -t ${BUILD_TIMEOUT} make -j${CPU_CORES}; \
    exit 0;
    

