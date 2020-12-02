CURRENT=$(shell pwd)
OS := $(shell uname)
NAME := $(shell basename ${CURRENT})
opts :=

.PHONY: ;

all:
	@echo No targets provided. Nothing to do.

init:
	helm plugin install https://github.com/lrills/helm-unittest
	helm repo add activiti https://activiti.github.io/activiti-cloud-helm-charts

build:
	helm dep build . ${opts}
	helm lint .

template:
	helm template . --set test=true ${opts}

verify: build
	helm unittest .

package: build verify
	helm package . ${opts}

install:
	helm upgrade $(NAME) --install . ${opts}

delete:
	helm delete $(NAME) --purge ${opts}
