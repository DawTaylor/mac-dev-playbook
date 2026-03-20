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
      "circleci"
      "dockutil"
      "esptool"
      "eza"
      "f3"
      "fd"
      "fzf"
      "gh"
      "helm"
      "jq"
      "libpq"
      "kubernetes-cli"
      "mas"
      "minikube"
      "nvm"
      "ollama"
      "podman"
      "podman-compose"
      "podman-tui"
      "pyenv"
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
      "android-platform-tools"
      "android-studio"
      "arduino-ide"
      "assinador-serpro"
      "bambu-studio"
      "chatgpt"
      "choosy"
      "claude"
      "claude-code"
      "codex"
      "codex-app"
      "db-browser-for-sqlite"
      "firefox"
      "font-hack-nerd-font"
      "font-inconsolata-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-meslo-lg-nerd-font"
      "font-open-sans"
      "font-sauce-code-pro-nerd-font"
      "font-sf-mono-nerd-font-ligaturized"
      "font-sf-pro"
      "font-ubuntu-mono-nerd-font"
      "font-ubuntu-nerd-font"
      "gcloud-cli"
      "ghostty"
      "github"
      "hammerspoon"
      "insomnia"
      "mqtt-explorer"
      "ngrok"
      "nordvpn"
      "notion"
      "pgadmin4"
      "pocket-casts"
      "postman"
      "sequel-ace"
      "sf-symbols"
      "slack"
      "steermouse"
      "telegram"
      "temurin@19"
      "tg-pro"
      "transmission"
      "unifi-identity-endpoint"
      "visual-studio-code"
      "whatsapp"
      "yubico-authenticator"
      "zen"
    ];

    # Mac App Store apps (requires mas to be installed)
    masApps = {
      "Tooth Fairy" = 1191449274;
      "Magnet" = 441258766;
      "1Password for Safari" = 1569813296;
    };
  };
}
