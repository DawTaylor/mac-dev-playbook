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
      "circleci"
      "dockutil"
      "esptool"
      "eza"
      "f3"
      "helm"
      "mas"
      "minikube"
      "nvm"
      "podman"
      "podman-tui"
      "pyenv"
      "terraform"
    ];

    # GUI applications (casks)
    casks = [
      # Password management
      "1password"
      "1password-cli"

      # Browsers
      "vivaldi"
      "firefox"

      # Development tools
      "arduino-ide"
      "db-browser-for-sqlite"
      "gcloud-cli"
      "ghostty"
      "insomnia"
      "ngrok"
      "pgadmin4"
      "postman"
      "visual-studio-code"

      # Design tools
      "sf-symbols"

      # Communication
      "chatgpt"
      "notion"
      "slack"
      "telegram"
      "whatsapp"

      # Utilities
      "airbuddy"
      "android-platform-tools"
      "choosy"
      "mqtt-explorer"
      "nordvpn"
      "pocket-casts"
      "steermouse"
      "tg-pro"
      "yubico-authenticator"

      # Regional/specific apps
      "assinador-serpro"
      "bambu-studio"

      # Java
      "temurin@19"

      # Fonts
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
    ];

    # Mac App Store apps (requires mas to be installed)
    masApps = {
      "Tooth Fairy" = 1191449274;
      "Magnet" = 441258766;
      "1Password for Safari" = 1569813296;
    };
  };
}
