{ pkgs, lib, username, hostname, ... }:

{
  imports = [
    ./homebrew.nix
    ./dock.nix
    ./npm.nix
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

  # Ensure Nix is in PATH for all zsh instances (including non-interactive/GUI)
  environment.etc."zshenv.local".text = ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

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

  # Mount the Nix Store APFS volume at boot (FileVault encrypts at container level,
  # so no passphrase needed — plain mount suffices once the system is unlocked)
  launchd.daemons.nix-store-mount = {
    serviceConfig = {
      Label = "org.nixos.darwin-store-mount";
      RunAtLoad = true;
      ProgramArguments = [
        "/bin/sh" "-c"
        "/usr/sbin/diskutil mount -mountPoint /nix 5F598E6D-98B2-4ED1-89D6-C8F17919AAAB"
      ];
    };
  };
}
