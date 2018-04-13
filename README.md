# Minimal emscripten environment inside Docker.

[![Build Status](https://travis-ci.org/jamesbrink/docker-emscripten.svg?branch=master)](https://travis-ci.org/jamesbrink/docker-emscripten) [![Docker Automated build](https://img.shields.io/docker/automated/jamesbrink/emscripten.svg)](https://hub.docker.com/r/jamesbrink/emscripten/) [![Docker Pulls](https://img.shields.io/docker/pulls/jamesbrink/emscripten.svg)](https://hub.docker.com/r/jamesbrink/emscripten/) [![Docker Stars](https://img.shields.io/docker/stars/jamesbrink/emscripten.svg)](https://hub.docker.com/r/jamesbrink/emscripten/) [![](https://images.microbadger.com/badges/image/jamesbrink/emscripten.svg)](https://microbadger.com/images/jamesbrink/emscripten "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jamesbrink/emscripten.svg)](https://microbadger.com/images/jamesbrink/emscripten "Get your own version badge on microbadger.com")  


## About

This is a work in progress, but the goal is to simply have a pre-configured [emscripten][emscripten] environment ready to go. I will attempt to minimize the image size but with this type of project and requirements I don't think I will be terribly successful. 

I am using the [Alpine Linux 3.7][Alpine Linux Image] image as a base, this in its self has produced some challenges, but hopefully the end result will be worth the effort.  

**Building this container can be very time consuming**

## Usage Examples

```shell
docker run -i -t --name emscripten jamesbrink/emscrpten
```

[emscripten]: https://github.com/kripken/emscripten
[Alpine Linux Image]: https://github.com/gliderlabs/docker-alpine

