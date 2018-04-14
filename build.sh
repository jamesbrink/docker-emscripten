#!/bin/bash

case "$1" in
    builder)
        export IMAGE_NAME="emscripten:builder"
        exec ./Dockerfile.stages/builder/hooks/build
    ;;
    z3)
        export IMAGE_NAME="emscripten:z3"
        export FROM_IMAGE="emscripten:builder"
        exec ./Dockerfile.stages/z3/hooks/build
    ;;
    fastcomp)
        export IMAGE_NAME="emscripten:fastcomp"
        export FROM_IMAGE="emscripten:builder"
        exec ./Dockerfile.stages/fastcomp/hooks/build
    ;;
    *)
        exit 1
    ;;
esac