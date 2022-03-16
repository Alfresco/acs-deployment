CURRENT=$(pwd)
NAME := alfresco-common
OS := $(shell uname)

plugin:
	helm plugin install https://github.com/quintush/helm-unittest || true

build: clean
	helm dep up
	helm lint

test: plugin
	helm unittest . --helm3

clean:
	rm -rf Chart.lock
	rm -rf charts
	rm -rf ${NAME}*.tgz

release: build
	helm package .
