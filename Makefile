# Makefile for Flutter Project with FVM

# Colors
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# FVM Commands
FLUTTER = fvm flutter
DART = fvm dart

# Help message
.PHONY: help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@echo '  ${GREEN}setup${RESET}        - Setup project (get dependencies & generate code)'
	@echo '  ${GREEN}get${RESET}          - Install all dependencies'
	@echo '  ${GREEN}generate${RESET}    - Generate code (build_runner, etc.)'
	@echo '  ${GREEN}run${RESET}         - Run the app in debug mode'
	@echo '  ${GREEN}build-runner${RESET} - Run build_runner with clean and watch'
	@echo '  ${GREEN}clean${RESET}       - Clean the project'
	@echo '  ${GREEN}format${RESET}      - Format the code'
	@echo '  ${GREEN}analyze${RESET}     - Analyze the code'
	@echo '  ${GREEN}test${RESET}        - Run all tests'
	@echo '  ${GREEN}doctor${RESET}      - Run flutter doctor'

# Setup project
.PHONY: setup
setup: get generate
	@echo "${GREEN}✓ Project setup complete!${RESET}"

# Install dependencies
.PHONY: get
get:
	@echo "${GREEN}Getting dependencies...${RESET}"
	@$(FLUTTER) pub get

# Generate code
.PHONY: generate
generate: get
	@echo "${GREEN}Generating code...${RESET}"
	@$(DART) run build_runner build --delete-conflicting-outputs

# Run the app
.PHONY: run
run: generate
	@echo "${GREEN}Running the app...${RESET}"
	@$(FLUTTER) run

# Watch for changes and generate code
.PHONY: build-runner
build-runner: get
	@echo "${GREEN}Starting build_runner in watch mode...${RESET}"
	@$(DART) run build_runner watch --delete-conflicting-outputs

# Clean the project
.PHONY: clean
clean:
	@echo "${GREEN}Cleaning...${RESET}"
	@$(FLUTTER) clean
	@$(DART) run build_runner clean
	@rm -rf .dart_tool/
	@rm -rf .packages
	@rm -f pubspec.lock

# Format code
.PHONY: format
format:
	@echo "${GREEN}Formatting code...${RESET}"
	@$(DART) format .

# Analyze code
.PHONY: analyze
analyze:
	@echo "${GREEN}Analyzing code...${RESET}"
	@$(DART) analyze .

# Run tests
.PHONY: test
test:
	@echo "${GREEN}Running tests...${RESET}"
	@$(FLUTTER) test

# Run flutter doctor
.PHONY: doctor
doctor:
	@echo "${GREEN}Running Flutter doctor...${RESET}"
	@$(FLUTTER) doctor -v

# Default target
.DEFAULT_GOAL := help
