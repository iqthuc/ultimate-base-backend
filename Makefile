.PHONY: all build test clean run migrate seed lint docker-up docker-down

# Variables
BUILD_DIR := build
CONFIG := configs/config.yaml

all: build

build:
	@echo "Building API server..."
	go build -o $(BUILD_DIR)/server ./cmd/server
	@echo "Building worker..."
	go build -o $(BUILD_DIR)/worker ./cmd/worker

test:
	@echo "Running tests..."
	go test -v ./...

run:
	@echo "Running API server..."
	go run ./cmd/server/main.go

worker:
	@echo "Running worker..."
	go run ./cmd/worker/main.go

seed:
	@echo "Seeding database..."
	./scripts/seed.sh

lint:
	@echo "Running linter..."
	golangci-lint run
