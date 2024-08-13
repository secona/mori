{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, catppuccin, ... }@inputs: let
    system = "x86_64-linux";
    hostname = "nixos";
    username = "secona";

    pkgs = import nixpkgs {
      config.allowUnfree = true;
      localSystem = { inherit system; };
    };

    extraSpecialArgs = {
      inherit pkgs system hostname username;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
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
