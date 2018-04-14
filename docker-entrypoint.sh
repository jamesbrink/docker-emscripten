#!/bin/bash
# emscripten entrypoint, not much here.

# source in the emscripten env.
source /emscripten/emsdk/emsdk_env.sh
exec ${@}
exit
