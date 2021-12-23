# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`
dpl ?= deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

GIT_COMMIT=$(shell git describe | sed 's/release-//')
GIT_STATUS=$(shell git status --porcelain)
GIT_MODIFIED := $(if $(GIT_STATUS),-M,)
VERSION=$(GIT_COMMIT)$(GIT_MODIFIED)
PORT=80

# HELP
# This will output the help for each task
# From: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(APP_NAME) .

build-nc: ## Build the container without caching
	docker build --no-cache -t $(APP_NAME) .

run: ## Run the container
	docker run -i -t --rm -p=$(PORT):$(PORT) --name="$(APP_NAME)" $(APP_NAME)

up: build run ## Build and run container

stop: ## Stop and remove a running container
	docker stop $(APP_NAME); docker rm $(APP_NAME)

release: build-nc publish ## Make a release by building and publishing the `{version}` and `latest` tagged containers to ECR

# Docker publish
publish: publish-latest publish-version ## Publish the `{version}` and `latest` tagged containers to ECR

publish-latest: tag-latest ## Publish the `latest` tagged container to ECR
	@echo 'publish latest to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):latest

publish-version: tag-version ## Publish the `{version}` tagged container to ECR
	@echo 'publish $(VERSION) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

# Docker tagging
tag: tag-latest tag-version ## Generate container tags for the `{version}` ans `latest` tags

tag-latest: ## Generate container `latest` tag
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):latest

tag-version: ## Generate container `{version}` tag
	@echo 'create tag $(VERSION)'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

# HELPERS

version: ## Output the current version
	@echo $(VERSION)

