# Label Studio ML Dummy Backend

A minimal dummy ML backend for Label Studio, managed with UV package manager.

## Overview

This project provides a simple skeleton implementation of a Label Studio ML backend using the `DummyModel` class. It serves as:
- A template for building custom ML backends
- A minimal working example for testing Label Studio integrations
- A demonstration of modern Python project management with UV

## Features

- ✅ **Minimal Implementation**: DummyModel returns basic predictions (score: 1.0)
- ✅ **UV Package Manager**: Modern, fast Python dependency management
- ✅ **Python 3.12.11**: Latest Python with full type hints support
- ✅ **Reproducible**: Lock file ensures identical environments
- ✅ **Flask API**: Standard Label Studio ML backend interface

## Quick Start

### Prerequisites

- Python 3.12.11
- UV package manager

If UV is not installed:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Automated Setup (Recommended)

Run the setup script to automatically create the environment:

```bash
./setup.sh
```

This will:
1. Sync all dependencies using `uv sync`
2. Install `label-studio-ml` from GitHub
3. Verify the installation

### Manual Setup

If you prefer manual setup:

```bash
# 1. Sync dependencies
uv sync --python 3.12.11 --no-editable --all-extras

# 2. Install label-studio-ml separately
uv pip install --no-deps "label-studio-ml @ git+https://github.com/HumanSignal/label-studio-ml-backend.git"
```

> **Why two-step installation?** `label-studio-ml` is installed separately because it's hosted on GitHub (not PyPI) and its dependency has upstream issues. Installing it with `--no-deps` after the main sync avoids dependency resolution conflicts.

### Verify Installation

```bash
# Activate the environment
source .venv/bin/activate

# Check Python version
python --version  # Should show 3.12.11

# Test imports
python -c "import model; print('✓ model.py works')"
python -c "import label_studio_ml; print('✓ label-studio-ml works')"
```

### Run the Server

```bash
# Activate the environment
source .venv/bin/activate

# Start the ML backend server
python _wsgi.py

# Or with custom options
python _wsgi.py --port 9090 --host 0.0.0.0
```

### Verify

```bash
# Check health
curl http://localhost:9090/health
# Expected: {"status":"UP"}
```

## Project Structure

```
.
├── model.py           # DummyModel implementation
├── _wsgi.py          # Flask server entry point
├── pyproject.toml    # UV project configuration
├── uv.lock           # Locked dependencies (commit to git!)
├── .python-version   # Python 3.12.11
├── setup.sh          # Automated setup script
└── README.md         # This file
```

### Key Files

- **`model.py`**: Minimal DummyModel implementation - customize this for your ML logic
- **`_wsgi.py`**: Flask server entry point - runs the ML backend API
- **`pyproject.toml`**: Project metadata and dependencies managed by UV
- **`uv.lock`**: Locked dependency versions for reproducibility (should be committed)
- **`setup.sh`**: One-command setup script for fresh installations

## Environment Reproducibility

The environment is fully reproducible using `uv.lock`:

1. Clone the repository
2. Run `./setup.sh`
3. Get the exact same environment on any machine

All dependencies (except `label-studio-ml`) are resolved from PyPI and locked in `uv.lock`.

## Connect to Label Studio

1. Start the ML backend server (default: `http://localhost:9090`)
2. In Label Studio, go to your project settings
3. Navigate to the **Model** page
4. Click **Connect Model**
5. Enter the URL: `http://localhost:9090`

## Development

### Customize the Model

Edit `model.py` to implement your custom ML logic:

```python
def predict(self, tasks: List[Dict], context: Optional[Dict] = None, **kwargs) -> List[Dict]:
    # Your custom prediction logic here
    predictions = []
    for task in tasks:
        predictions.append({
            'result': [],  # Your predictions
            'score': 1.0,
            'model_version': self.get('model_version'),
        })
    return predictions
```

### Run Tests

```bash
pytest
```

## Requirements

- **Python**: 3.12.11 (managed by UV)
- **Package Manager**: UV
- **Dependencies**: Defined in `pyproject.toml`, locked in `uv.lock`

Key dependencies:
- Flask 3.x + Gunicorn 23.0.0 (web framework)
- label-studio-ml + label-studio-sdk 2.0+ (ML backend)
- pytest + pytest-cov (testing)

## Troubleshooting

### UV not found
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc  # or restart your terminal
```

### Import errors
Make sure you activated the environment and ran the full setup:
```bash
source .venv/bin/activate
./setup.sh
```

### Server won't start
Check if the port is already in use:
```bash
lsof -i :9090
# Kill the process if needed
```

## License

MIT

## More Information

- [Label Studio Documentation](https://labelstud.io/)
- [Label Studio ML Backend](https://github.com/HumanSignal/label-studio-ml-backend)
- [UV Documentation](https://docs.astral.sh/uv/)
