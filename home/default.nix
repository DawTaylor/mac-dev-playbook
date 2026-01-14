{ pkgs, lib, inputs, username, ... }:

{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";

    # Packages installed via Nix
    # Note: Most CLI tools are installed via Homebrew for simpler PATH management
    # Only packages that work better with Nix or aren't in Homebrew go here
    packages = with pkgs; [
      stow  # Used by dotfiles activation script
    ];

    # Dotfiles activation - copies from nix store and runs stow
    activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      DOTFILES_DIR="$HOME/dotfiles"

      # Remove existing dotfiles dir if it's a symlink or empty
      if [ -L "$DOTFILES_DIR" ] || [ -z "$(ls -A "$DOTFILES_DIR" 2>/dev/null)" ]; then
        rm -rf "$DOTFILES_DIR"
      fi

      # Copy dotfiles from nix store (if not already present)
      if [ ! -d "$DOTFILES_DIR" ]; then
        cp -r ${inputs.dotfiles} "$DOTFILES_DIR"
        chmod -R u+w "$DOTFILES_DIR"
      fi

      # Run stow to create symlinks
      cd "$DOTFILES_DIR"
      ${pkgs.stow}/bin/stow --adopt . 2>/dev/null || true
      ${pkgs.git}/bin/git checkout . 2>/dev/null || true
      ${pkgs.stow}/bin/stow --restow . 2>/dev/null || true
    '';
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Shell configuration - disabled, managed by dotfiles
  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;
  #   shellAliases = { ... };
  # };

  # Git configuration - disabled, managed by dotfiles
  # programs.git = {
  #   enable = true;
  # };
}
