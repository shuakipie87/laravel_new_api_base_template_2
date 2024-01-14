.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=api
CONTAINER_REDIS=redis
CONTAINER_DATABASE=database

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: ## Auth for AWS
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 392581226020.dkr.ecr.us-east-1.amazonaws.com

build-push:
	make build
	make push

build: ## Build our prod image
	docker build -t new-elactic-base .

push: ## Push to prod image
	docker tag new-elactic-base:latest 392581226020.dkr.ecr.us-east-1.amazonaws.com/new-elactic-base:latest
	docker push 392581226020.dkr.ecr.us-east-1.amazonaws.com/new-elactic-base:latest