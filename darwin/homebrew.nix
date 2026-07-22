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
      extraFlags = [ "--force-cleanup" ];
    };

    # Homebrew taps
    taps = [
      "fluxcd/tap"
      "siderolabs/tap"
    ];

    # CLI tools (formulae) - these are installed via Homebrew
    # Some of these have Nix equivalents but work better via Homebrew on macOS
    brews = [
      "awscli"
      "bat"
      "cloudflared"
      "dockutil"
      "esptool"
      "eza"
      "f3"
      "fd"
      "flux"
      "fzf"
      "gh"
      "helm"
      "jq"
      "kubernetes-cli"
      "kustomize"
      "mas"
      "minikube"
      "nvm"
      "ollama"
      "python"
      "podman"
      "podman-compose"
      "podman-tui"
      "ripgrep"
      "tailscale"
      "talosctl"
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
      "arduino-ide"
      "balenaetcher"
      "chatgpt"
      "claude"
      "claude-code"
      "firefox"
      "font-sf-mono-nerd-font-ligaturized"
      "font-sf-pro"
      "gcloud-cli"
      "logi-options+"
      "mactracker"
      "mqttx"
      "nordvpn"
      "notion"
      "pocket-casts"
      "sequel-ace"
      "sf-symbols"
      "slack"
      "telegram"
      "temurin@17"
      "ungoogled-chromium"
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
