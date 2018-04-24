#!/usr/bin/make -f

NAME=jamesbrink/emscripten
TEMPLATE=Dockerfile.template
DOCKER_COMPOSE_TEMPLATE=docker-compose.template
# Build Timeout of 40m
BUILD_TIMEOUT=2400
.PHONY: test all clean builder z3 fastcomp_fetch fastcomp_stage1 fastcomp_stage2 fastcomp_stage3 fastcomp_stage4 fastcomp
.DEFAULT_GOAL := builder 

all: builder z3 fastcomp_fetch fastcomp_stage1 fastcomp_stage2 fastcomp_stage3 fastcomp_stage4 fastcomp

builder:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.$(@).template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	cd $(@) && docker build -t $(NAME):$(@) .

z3:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.$(@).template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's|ARG FROM_IMAGE.*|ARG FROM_IMAGE="$(NAME):builder"|g' $(@)/Dockerfile
	sed -i -r 's|ARG CPU_CORES.*|ARG CPU_CORES="4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG Z3_VERSION.*|ARG Z3_VERSION="z3-4.6.0"|g' $(@)/Dockerfile
	cd $(@) && docker build -t $(NAME):$(@) .

fastcomp_fetch:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.$(@).template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's|ARG FROM_IMAGE.*|ARG FROM_IMAGE="$(NAME):z3"|g' $(@)/Dockerfile
	sed -i -r 's|ARG CPU_CORES.*|ARG CPU_CORES="4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG SDK_VERSION.*|ARG SDK_VERSION="1.37.37"|g' $(@)/Dockerfile
	cd $(@) && docker build -t $(NAME):$(@) .

fastcomp_stage1:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.fastcomp_stage.template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's|ARG FROM_IMAGE.*|ARG FROM_IMAGE="$(NAME):fastcomp_fetch"|g' $(@)/Dockerfile
	sed -i -r 's|ARG CPU_CORES.*|ARG CPU_CORES="4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG SDK_VERSION.*|ARG SDK_VERSION="1.37.37"|g' $(@)/Dockerfile
	sed -i -r 's|ARG BUILD_TIMEOUT.*|ARG BUILD_TIMEOUT=$(BUILD_TIMEOUT)|g' $(@)/Dockerfile
	cd $(@) && docker build -t $(NAME):$(@) .

fastcomp_stage2:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.fastcomp_stage.template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's|ARG FROM_IMAGE.*|ARG FROM_IMAGE="$(NAME):fastcomp_stage1"|g' $(@)/Dockerfile
	sed -i -r 's|ARG CPU_CORES.*|ARG CPU_CORES="4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG SDK_VERSION.*|ARG SDK_VERSION="1.37.37"|g' $(@)/Dockerfile
	sed -i -r 's|ARG BUILD_TIMEOUT.*|ARG BUILD_TIMEOUT=$(BUILD_TIMEOUT)|g' $(@)/Dockerfile
	cd $(@) && docker build -t $(NAME):$(@) .

fastcomp_stage3:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.fastcomp_stage.template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's|ARG FROM_IMAGE.*|ARG FROM_IMAGE="$(NAME):fastcomp_stage2"|g' $(@)/Dockerfile
	sed -i -r 's|ARG CPU_CORES.*|ARG CPU_CORES="4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG SDK_VERSION.*|ARG SDK_VERSION="1.37.37"|g' $(@)/Dockerfile
	sed -i -r 's|ARG BUILD_TIMEOUT.*|ARG BUILD_TIMEOUT=$(BUILD_TIMEOUT)|g' $(@)/Dockerfile
	cd $(@) && docker build -t $(NAME):$(@) .

fastcomp_stage4:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.fastcomp_stage.template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's|ARG FROM_IMAGE.*|ARG FROM_IMAGE="$(NAME):fastcomp_stage3"|g' $(@)/Dockerfile
	sed -i -r 's|ARG CPU_CORES.*|ARG CPU_CORES="4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG SDK_VERSION.*|ARG SDK_VERSION="1.37.37"|g' $(@)/Dockerfile
	sed -i -r 's|ARG BUILD_TIMEOUT.*|ARG BUILD_TIMEOUT=$(BUILD_TIMEOUT)|g' $(@)/Dockerfile
	cd $(@) && docker build -t $(NAME):$(@) .

fastcomp:
	mkdir -p $(@)
	cp -rp hooks $(@)
	cp Dockerfile.$(@).template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's|ARG FROM_IMAGE.*|ARG FROM_IMAGE="$(NAME):fastcomp_stage4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG CPU_CORES.*|ARG CPU_CORES="4"|g' $(@)/Dockerfile
	sed -i -r 's|ARG SDK_VERSION.*|ARG SDK_VERSION="1.37.37"|g' $(@)/Dockerfile
	cd $(@) && docker build -t $(NAME):$(@) .

test: test-builder

test-builder:
	docker run -it --rm $(NAME):builder ps; if [ $$? -ne 0 ]; then exit 1;fi


clean:
	rm -rf builder z3 fastcomp_fetch fastcomp_stage1 fastcomp_stage2 fastcomp_stage3 fastcomp_stage4 fastcomp
