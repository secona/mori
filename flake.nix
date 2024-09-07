{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, nixpkgs-unstable, home-manager, catppuccin, nixvim, ... }@inputs: let
    system = "x86_64-linux";
    hostname = "osiris";
    username = "secona";

    pkgs = import nixpkgs {
      config.allowUnfree = true;
      localSystem = { inherit system; };
    };

    pkgs-unstable = import nixpkgs-unstable {
      config.allowUnfree = true;
      localSystem = { inherit system; };
    };

    extraSpecialArgs = {
      inherit pkgs pkgs-unstable system hostname username inputs;
    };
  in {
    nixosConfigurations.osiris = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit pkgs-unstable; };

      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        catppuccin.nixosModules.catppuccin
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = {
            imports = [
              ./home.nix
              catppuccin.homeManagerModules.catppuccin
            ];
          };
          home-manager.extraSpecialArgs = extraSpecialArgs;
        }
      ];
    };
  };
}
