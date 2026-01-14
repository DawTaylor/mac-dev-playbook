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

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
    let
      # Change this to your username
      username = "daw";

      # System configuration
      system = "aarch64-darwin"; # Use "x86_64-darwin" for Intel Macs

      specialArgs = { inherit inputs username; };
    in
    {
      darwinConfigurations."MacBook-Pro-de-Adalberto" = nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          ./darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.${username} = import ./home;
            };
          }
        ];
      };

      # Convenience output for `darwin-rebuild switch --flake .`
      darwinConfigurations.default = self.darwinConfigurations."MacBook-Pro-de-Adalberto";
    };
}
