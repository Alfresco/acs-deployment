OS := $(shell uname)

NAME := $(shell sed -n 's/^name: //p' Chart.yaml)
CURRENT_VERSION := $(shell sed -n 's/^version: //p' Chart.yaml)
RELEASE_VERSION := $(shell .cmd/new-version.sh $(CURRENT_VERSION))

build: clean
	rm -rf requirements.lock
	helm dependency build
	helm lint

clean:
	rm -rf charts
	rm -rf ${NAME}*.tgz

# this will clean build and package your helm chart
# it will also save it to your local helm repository
# you can serve it using: $ helm serve (or calling: $ make local-repo)
package: build	
	helm init --client-only
	helm package .	
	helm search local/$(NAME) -l
	rm -rf ${NAME}*.tgz%

tag:
ifeq ($(OS),Darwin)
	sed -i "" -e "s/version:.*/version: $(RELEASE_VERSION)/" Chart.yaml
	sed -i "" -e "s/tag: .*/tag: $(RELEASE_VERSION)/" values.yaml
else ifeq ($(OS),Linux)
	sed -i -e "s/version:.*/version: $(RELEASE_VERSION)/" Chart.yaml	
	sed -i -e "s/tag: .*/tag: $(RELEASE_VERSION)/" values.yaml
else
	echo "platfrom $(OS) not supported to release from"
	exit -1
endif

release-tag:	
	git add --all
	git commit -m "release $(NAME) v.$(RELEASE_VERSION) chart" --allow-empty # if first release then no verion update is performed
	git tag -fa v$(RELEASE_VERSION) -m "Release version $(RELEASE_VERSION)"
	git push origin v$(RELEASE_VERSION)

local-repo:
	.cmd/serve-helm.sh