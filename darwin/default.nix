{ pkgs, username, ... }:

{
  imports = [
    ./homebrew.nix
    ./dock.nix
    ./system.nix
  ];

  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Garbage collection
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true
    }
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

  # Used for backwards compatibility
  system.stateVersion = 5;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";

  # User configuration
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # Set the primary user for nix-darwin
  system.primaryUser = username;

  # Networking
  networking = {
    computerName = "macbook";
    hostName = "macbook";
  };

  # Security - Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
