ARG FROM_IMAGE="jamesbrink/emscripten:fastcomp_stage4"

FROM ${FROM_IMAGE}

# Build Stage ARGs
ARG SDK_VERSION="1.37.37"
ARG CPU_CORES="4"

RUN set -xe; \
    cd /build/emscripten-fastcomp/build; \
    echo "CPU_CORES=${CPU_CORES}"; \
    make -j${CPU_CORES};
    
    

