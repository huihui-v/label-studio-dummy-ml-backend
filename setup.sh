#!/usr/bin/env bash
# Setup script for label-studio-ml-dummy project
# This script recreates the development environment using uv

set -e  # Exit on error

echo "Setting up label-studio-ml-dummy environment..."

# Check if uv is installed
if ! command -v uv >/dev/null 2>&1; then
    echo "Error: uv is not installed. Please install it first:"
    echo "  curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

# Sync dependencies from pyproject.toml and uv.lock
echo "1. Syncing dependencies with uv..."
uv sync --python 3.12.11 --no-editable --all-extras

# Install label-studio-ml separately (due to upstream dependency issues)
echo "2. Installing label-studio-ml from git..."
uv pip install --no-deps "label-studio-ml @ git+https://github.com/HumanSignal/label-studio-ml-backend.git"

# Verify installation
echo "3. Verifying installation..."
.venv/bin/python --version
.venv/bin/python -c "import model; from model import DummyModel; print('✓ model.py imports successfully')"
.venv/bin/python -c "import label_studio_ml; print('✓ label-studio-ml installed successfully')"

echo ""
echo "✓ Setup complete!"
echo ""
echo "To activate the environment, run:"
echo "  source .venv/bin/activate"
echo ""
echo "To run the server:"
echo "  uv run python _wsgi.py"
