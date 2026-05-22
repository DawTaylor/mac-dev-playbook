{ pkgs, username, ... }:

let
  # Global npm packages to install
  npmPackages = [
    "@github/copilot"
    "@tuyapi/cli"
    "http-serve"
    "ts-node"
    "vercel"
  ];

  packageList = builtins.concatStringsSep " " npmPackages;

  # Script stored as a Nix derivation to avoid shell quoting issues
  npmSetupScript = pkgs.writeShellScript "npm-global-setup" ''
    export NVM_DIR="$HOME/.nvm"
    NVM_SCRIPT="/opt/homebrew/opt/nvm/nvm.sh"

    if [ -s "$NVM_SCRIPT" ]; then
      # shellcheck source=/dev/null
      . "$NVM_SCRIPT"
      nvm use default > /dev/null 2>&1

      if command -v npm > /dev/null 2>&1; then
        for pkg in ${packageList}; do
          if ! npm list -g "$pkg" > /dev/null 2>&1; then
            echo "  Installing $pkg..."
            npm install -g "$pkg"
          fi
        done
        echo "Global npm packages are up to date."
      else
        echo "  Warning: npm not found. Skipping global npm package installation."
        echo "  Run: nvm install --lts"
      fi
    else
      echo "  Warning: nvm not found. Skipping global npm package installation."
    fi
  '';
in
{
  # Install global npm packages after nvm/node is available
  # Runs as the user (not root) so nvm and npm use the correct home directory
  system.activationScripts.postActivation.text = ''
    echo "Installing global npm packages..."
    sudo -i -u ${username} ${npmSetupScript}
  '';
}
