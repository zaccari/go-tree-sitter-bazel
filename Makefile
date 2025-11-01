
.PHONY: build
build: ## Build go-tree-sitter
	bazelisk build //:go-tree-sitter

.PHONY: query
query: ## Query all Bazel targets
	bazelisk query //...

.PHONY: help
help: ## Show this help message
	@echo "Available targets:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
