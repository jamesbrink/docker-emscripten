#!/bin/bash

case "$1" in
    builder)
        export IMAGE_NAME="emscripten:builder"
        cd ./Dockerfile.stages/builder
        exec ./hooks/build
    ;;
    z3)
        export IMAGE_NAME="emscripten:z3"
        export FROM_IMAGE="emscripten:builder"
        cd ./Dockerfile.stages/z3
        exec ./hooks/build
    ;;
    fastcomp)
        export IMAGE_NAME="emscripten:fastcomp"
        export FROM_IMAGE="emscripten:builder"
        cd ./Dockerfile.stages/fastcomp
        exec ./hooks/build
    ;;
    *)
        exit 1
    ;;
esac