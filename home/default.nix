{ pkgs, username, ... }:

{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";

    # Packages installed via Nix (CLI tools that work well with Nix)
    packages = with pkgs; [
      # Core utilities
      bat           # Better cat
      eza           # Better ls
      fd            # Better find
      fzf           # Fuzzy finder
      jq            # JSON processor
      ripgrep       # Better grep
      tlrc          # tldr client

      # Kubernetes
      kubectl
      kubernetes-helm

      # Database
      sqlite

      # Version control
      git
      stow          # Dotfiles management

      # Development
      nodejs_20
      nodePackages.typescript
      nodePackages.ts-node
    ];
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      cat = "bat";
      k = "kubectl";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    # Add your git config here or let dotfiles handle it
    # userName = "Your Name";
    # userEmail = "your@email.com";
  };

  # fzf integration
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # bat configuration
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  # eza configuration
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };
}
