#!/usr/bin/env bash
set -e

echo "Mac Development Setup (Nix)"
echo "============================"

# Check if Nix is installed
if ! command -v nix &> /dev/null; then
    echo "Nix is not installed. Installing via Determinate Systems installer..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    echo ""
    echo "Nix installed. Please restart your terminal and run this script again."
    exit 0
fi

# Get the current hostname
HOSTNAME=$(hostname)
echo "Detected hostname: $HOSTNAME"

# Check if hostname exists in flake.nix
if ! grep -q "\"$HOSTNAME\"" flake.nix; then
    echo ""
    echo "WARNING: Hostname '$HOSTNAME' not found in flake.nix"
    echo "Please add your machine to the 'machines' attribute in flake.nix:"
    echo ""
    echo "  \"$HOSTNAME\" = {"
    echo "    hostname = \"$HOSTNAME\";"
    echo "    system = \"aarch64-darwin\";  # or x86_64-darwin for Intel"
    echo "  };"
    echo ""
    exit 1
fi

# Check if this is a first-time setup or an update
if command -v darwin-rebuild &> /dev/null; then
    echo "nix-darwin is already installed. Running darwin-rebuild..."
    sudo darwin-rebuild switch --flake .
else
    echo "First-time setup. Bootstrapping nix-darwin..."
    sudo nix run nix-darwin -- switch --flake .
fi

echo ""
echo "Setup complete!"
