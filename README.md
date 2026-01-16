# Mac Development Nix Configuration

This repository uses [Nix](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager) to configure macOS for development. It manages system settings, Homebrew packages, dock configuration, and dotfiles declaratively.

## Prerequisites

- macOS (Apple Silicon or Intel)
- Admin access to your Mac

## Installation

1. Install Nix using the Determinate Systems installer:

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. Clone this repository:

   ```bash
   git clone https://github.com/DawTaylor/mac-dev-playbook.git
   cd mac-dev-playbook
   ```

3. Add your machine to `flake.nix` if it's not already listed. Find your hostname with:

   ```bash
   hostname
   ```

   Then add an entry in the `machines` attribute set in `flake.nix`.

4. Run the setup script:

   ```bash
   ./setup.sh
   ```

   Or manually build and switch:

   ```bash
   nix run nix-darwin -- switch --flake .
   ```

## Updating

To apply configuration changes or update packages:

```bash
sudo darwin-rebuild switch --flake .
```

To update all flake inputs (nixpkgs, nix-darwin, home-manager, dotfiles):

```bash
nix flake update
sudo darwin-rebuild switch --flake .
```

## Project Structure

```
.
├── flake.nix           # Flake definition with machine configurations
├── darwin/
│   ├── default.nix     # Main nix-darwin configuration
│   ├── homebrew.nix    # Homebrew packages (brews, casks, Mac App Store)
│   ├── dock.nix        # Dock apps and folders configuration
│   └── system.nix      # macOS system preferences
└── home/
    └── default.nix     # Home-manager configuration (user packages, dotfiles)
```

## What's Configured

### System Settings (`darwin/system.nix`)

- Dock: auto-hide, no recent apps, bottom orientation
- Finder: show extensions, path bar, status bar
- Keyboard: fast key repeat, no auto-capitalization/correction
- Trackpad: tap to click, right-click enabled
- Security: Touch ID for sudo

### Homebrew Packages (`darwin/homebrew.nix`)

**CLI Tools (brews):**
awscli, bat, eza, fd, fzf, helm, jq, nvm, podman, pyenv, ripgrep, terraform, and more

**GUI Applications (casks):**
- Browsers: Vivaldi, Firefox
- Development: VS Code, Ghostty, Insomnia, Postman
- Communication: Slack, Notion, Telegram, WhatsApp
- Utilities: 1Password, NordVPN, Magnet

**Mac App Store:**
Tooth Fairy, Magnet, 1Password for Safari

### Dock (`darwin/dock.nix`)

Persistent apps and folders with custom display settings.

### Dotfiles (`home/default.nix`)

Dotfiles are fetched from [github.com/DawTaylor/dotfiles](https://github.com/DawTaylor/dotfiles) and installed using GNU Stow.

## Adding a New Machine

1. Get the hostname of your new Mac:

   ```bash
   hostname
   ```

2. Add it to the `machines` attribute in `flake.nix`:

   ```nix
   machines = {
     "Your-Hostname" = {
       hostname = "Your-Hostname";
       system = "aarch64-darwin";  # or "x86_64-darwin" for Intel
     };
   };
   ```

3. Run the setup:

   ```bash
   ./setup.sh
   ```

## Customization

### Adding Homebrew Packages

Edit `darwin/homebrew.nix`:

```nix
brews = [
  "your-cli-tool"
];

casks = [
  "your-gui-app"
];
```

### Adding Dock Apps

Edit `darwin/dock.nix`:

```nix
persistent-apps = [
  "/Applications/YourApp.app"
];
```

### Changing System Settings

Edit `darwin/system.nix` to modify macOS preferences.

## Troubleshooting

### Homebrew Issues

If Homebrew commands fail, try:

```bash
brew doctor
```

### Nix Garbage Collection

To free up disk space:

```bash
nix-collect-garbage -d
```

### Rebuild After Errors

If activation fails, fix the issue and rebuild:

```bash
sudo darwin-rebuild switch --flake .
```

## Credits

Originally based on [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) (Ansible), migrated to Nix for declarative, reproducible configuration.
