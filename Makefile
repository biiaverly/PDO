# Default shell
SHELL = /bin/sh

# Variables
ENV = localhost
PROJECT_NAME = PDO
PWD ?= pwd_unknown
PROJECT= $(shell echo ${PROJECT_NAME} | tr '[:lower:]' '[:upper:]' | tr '-' '_')
export PROJECT

# Docker compose version.
ifneq (,$(wildcard /usr/local/bin/docker-compose))
	DOCKER_COMPOSE := docker-compose
else
	DOCKER_COMPOSE := docker compose
endif

# Database variables
DB_DATABASE = PDO
DB_PASSWORD = root
DB_USERNAME = root

# UID of the current user
WWWUSER := $(shell id -u)

# GID of the current user
WWWGROUP := $(shell id -g)

# Export such that its passed to shell functions for Docker to pick up.
export PROJECT_NAME
export ENV
export DB_DATABASE
export DB_PASSWORD
export DB_USERNAME
export DOCKER_COMPOSE
export WWWUSER
export WWWGROUP
export port

# Functions 
.DEFAULT_GOAL := help
.PHONY: start
start: ## Start the Project Container.
	@echo
	@printf "\033[1;33m Starting ${PROJECT_NAME}... 🚀\033[0m"
	@echo
	@$(DOCKER_COMPOSE) stop $(c)
	@$(DOCKER_COMPOSE) build --build-arg=PORT="${port}" $(c)
	@$(DOCKER_COMPOSE) up -d $(c)
	@printf "\033[1;32m\n✅ Command \`make start\` executed successfully. \033[0m"
	@echo

.PHONY: stop
stop: ## Parar o projeto.
	@$(DOCKER_COMPOSE) stop $(c)

.PHONY: help
help: ## HELP.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)