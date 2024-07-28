.PHONY: build up stop down install-lint lint help
.DEFAULT_GOAL := help

build: ## build the docker image
	docker compose -f ./compose.yaml build

up: ## start the docker container
	make down
	docker compose -f ./compose.yaml up

stop: ## stop the docker container
	docker compose -f ./compose.yaml stop

down: ## stop and remove the docker container
	docker compose -f ./compose.yaml down

install-lint: ## install the linter
	go install mvdan.cc/gofumpt@latest
	go install github.com/segmentio/golines@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

lint: ## run the linter | vscode를 쓰는 사람은 실시간으로 적용 중. 할 필요 없음
	gofumpt -w .
	golines -w .
	golangci-lint run

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'