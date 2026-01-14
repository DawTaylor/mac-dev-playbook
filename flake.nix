{
  description = "Darwin system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "github:DawTaylor/dotfiles";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, dotfiles }:
    let
      # Shared configuration
      username = "daw";

      # Helper function to create a darwin system configuration
      mkDarwinSystem = { hostname, system ? "aarch64-darwin" }:
        let
          specialArgs = { inherit inputs username hostname; };
        in
        nix-darwin.lib.darwinSystem {
          inherit system specialArgs;
          modules = [
            ./darwin
            home-manager.darwinModules.home-manager
            {
              # Set hostname for this machine
              networking.hostName = hostname;
              networking.computerName = hostname;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
                backupFileExtension = "backup";
                users.${username} = import ./home;
              };
            }
          ];
        };

      # Define your machines here
      machines = {
        # Personal MacBook (M-series)
        "MacBook-Pro-de-Adalberto" = {
          hostname = "MacBook-Pro-de-Adalberto";
          system = "aarch64-darwin";
        };

        # Work MacBook (M-series) - update hostname to match your second Mac
        "MacBook-Work" = {
          hostname = "MacBook-Work";
          system = "aarch64-darwin";
        };

        # Example: Intel Mac
        # "MacBook-Intel" = {
        #   hostname = "MacBook-Intel";
        #   system = "x86_64-darwin";
        # };
      };
    in
    {
      # Generate darwinConfigurations for each machine
      darwinConfigurations = builtins.mapAttrs
        (name: config: mkDarwinSystem config)
        machines;
    };
}
