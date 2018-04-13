# emscripten
#
# VERSION 0.0.0

FROM alpine:3.7

ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="James Brink, brink.james@gmail.com" \
    decription="emscripten" \
    version="0.0.0" \
    org.label-schema.name="emscripten" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/jamesbrink/docker-tesseract" \
    org.label-schema.schema-version="1.0.0-rc1"

# Create our emscripten user
RUN addgroup -g 1000 -S emscripten \
    && adduser -u 1000 -S -h /emscripten -s /bin/sh -G emscripten emscripten

# Install all needed build &runtime dependencies.
RUN set -xe; \
    echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "@edgecommunity http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk --update --no-cache upgrade; \
    apk add --update --no-cache --virtual .build-deps \
        alpine-sdk \
        automake \
        bash \
        clang \
        cmake \
        git \
        libexecinfo-dev \
        llvm5-dev \
        m4 \
        mercurial \
        nodejs \
        nodejs-dev \
        openjdk8-jre-base \
        patch \
        pcre-dev \
        python2-dev \
        vim \
        xz; \
    apk add --update --no-cache \
        gosu@testing \
        ocaml-dev@edgecommunity \
        opam@edge; \
    cd /emscripten; \
    git clone https://github.com/Z3Prover/z3.git; \
    cd /emscripten/z3; \
    git checkout z3-4.6.0; \
    CXX=clang++ CC=clang python scripts/mk_make.py; \
    cd build; \
    make; \
    make install; \
    cd /emscripten; \
    rm -rf z3;

# Drop down to unpriviledged user.   
USER emscripten

# Set our working directory.
WORKDIR /emscripten

# Setup opam deps, and compile emsdk.
RUN set -xe; \
    opam init; \
    opam install conf-m4 ocamlfind; \
    export PATH="/emscripten/.opam/system/bin/:$PATH"; \
    git clone https://github.com/juj/emsdk.git; \
    cd /emscripten/emsdk/; \
    ./emsdk install sdk-incoming-64bit;

# Setup the emsdk environment.
RUN set -xe; \
    ./emsdk activate sdk-incoming-64bit; \
    sed -ir "s#NODE_JS=.*#NODE_JS='/usr/bin/node#g" /emscripten/.emscripten; \
    source ./emsdk_env.sh; \
    emcc -v;

# Copy in our docker assets.
COPY ./docker-entrypoint.sh /usr/local/bin/entrypoint.sh

# Set the entrypoint.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]