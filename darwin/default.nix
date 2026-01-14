{ pkgs, lib, username, hostname, ... }:

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
      automatic = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

  # Used for backwards compatibility
  system.stateVersion = 5;

  # The platform the configuration will be used on
  # This is set dynamically based on the machine config in flake.nix
  # nixpkgs.hostPlatform is inherited from the system parameter

  # User configuration
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # Set the primary user for nix-darwin
  system.primaryUser = username;

  # Networking - hostName and computerName are set per-machine in flake.nix

  # Security - Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
