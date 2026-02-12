.PHONY: build run shell clean demo help

# Variables
IMAGE_NAME = ctx-demo
CONTAINER_NAME = ctx-demo-container

help: ## Show this help message
	@echo "ctx_ Demo Environment"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build the demo Docker image
	@echo "Building ctx demo image..."
	docker build -t $(IMAGE_NAME) .
	@echo "✓ Image built successfully"

run: ## Run the demo container interactively
	@echo "Starting ctx demo container..."
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-v $(PWD)/contexts:/home/demo/.config/ctx/contexts:ro \
		$(IMAGE_NAME) /bin/bash

shell: run ## Alias for run

demo: ## Run the guided demo script
	@echo "Starting guided demo..."
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-v $(PWD)/contexts:/home/demo/.config/ctx/contexts:ro \
		$(IMAGE_NAME) /bin/bash /home/demo/demo.sh

clean: ## Remove demo image and containers
	@echo "Cleaning up..."
	-docker rm -f $(CONTAINER_NAME) 2>/dev/null || true
	-docker rmi $(IMAGE_NAME) 2>/dev/null || true
	@echo "✓ Cleanup complete"

rebuild: clean build ## Clean and rebuild the image

test: ## Quick test that ctx is working
	@echo "Testing ctx installation..."
	docker run --rm $(IMAGE_NAME) ctx --version
	@echo "✓ ctx is working"
