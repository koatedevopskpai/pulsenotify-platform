.PHONY: help install lint test docker-build docker-up docker-down clean

help:
	@grep -E '^[a-zA-Z_-]+:.*#' Makefile | sort | \
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install:  # Install Python dependencies
	pip install -r requirements.txt

lint:  # Run linter
	flake8 app

test:  # Run tests with coverage
	pytest --cov=app --cov-report=term-missing -v

docker-build:  # Build Docker image
	docker compose build

docker-up:  # Start local stack
	docker compose up -d

docker-down:  # Stop local stack
	docker compose down -v

clean:  # Remove Python cache
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
