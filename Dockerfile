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

# Drop down to unpriviledged user.   
USER emscripten

# Set our working directory.
WORKDIR /emscripten