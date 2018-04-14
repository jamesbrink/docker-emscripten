# emscripten
#
# VERSION 0.0.0

FROM alpine:3.7

ARG VCS_REF
ARG BUILD_DATE

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
    mkdir -p /build;

# Install ocamlfind
RUN set -xe; \
    opam init; \
    opam install conf-m4 ocamlfind;

# Set our working directory for 
# additional builds.
WORKDIR /build

