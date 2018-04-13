#!/bin/sh
# emscripten entrypoint, not much here.

# source in the emscripten env.
source /emscripten/emsdk_env.sh
exec ${@}
exit
