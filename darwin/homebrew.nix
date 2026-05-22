{ pkgs, ... }:

{
  # Enable Homebrew management through nix-darwin
  homebrew = {
    enable = true;

    # Behavior settings
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "zap" removes unlisted casks/formulae, "uninstall" only removes managed ones
      # Use "none" to be conservative, "uninstall" for managed cleanup
      cleanup = "uninstall";
    };

    # Homebrew taps
    taps = [
    ];

    # CLI tools (formulae) - these are installed via Homebrew
    # Some of these have Nix equivalents but work better via Homebrew on macOS
    brews = [
      "awscli"
      "bat"
      "dockutil"
      "esptool"
      "eza"
      "f3"
      "fd"
      "fzf"
      "gh"
      "helm"
      "jq"
      "kubernetes-cli"
      "mas"
      "minikube"
      "nvm"
      "ollama"
      "podman"
      "podman-compose"
      "podman-tui"
      "ripgrep"
      "terraform"
      "tlrc"
    ];

    # GUI applications (casks)
    casks = [
      "1password"
      "1password-cli"
      "affinity"
      "airbuddy"
      "arduino-ide"
      "bambu-studio"
      "chatgpt"
      "cinebench"
      "claude-code"
      "font-sf-mono-nerd-font-ligaturized"
      "font-sf-pro"
      "gcloud-cli"
      "ghostty"
      "github"
      "mqttx"
      "nordvpn"
      "notion"
      "pocket-casts"
      "postman"
      "sf-symbols"
      "slack"
      "telegram"
      "unifi-identity-endpoint"
      "visual-studio-code"
      "warp"
      "whatsapp"
      "yubico-authenticator"
    ];

    # Mac App Store apps (requires mas to be installed)
    masApps = {
      "Tooth Fairy" = 1191449274;
      "Magnet" = 441258766;
      "1Password for Safari" = 1569813296;
      "The Unarchiver" = 425424353;
    };
  };
}
