{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    catppuccin,
    nixvim,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    hostname = "guts";
    username = "secona";

    pkgs = import nixpkgs {
      config.allowUnfree = true;
      localSystem = {inherit system;};
    };

    pkgs-unstable = import nixpkgs-unstable {
      config.allowUnfree = true;
      localSystem = {inherit system;};
    };

    extraSpecialArgs = {
      inherit pkgs pkgs-unstable system hostname username inputs;
    };
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations.guts = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {inherit pkgs-unstable;};

      modules = [
        ./hosts/guts/configuration.nix
        home-manager.nixosModules.default
        nixos-hardware.nixosModules.lenovo-ideapad-15ach6
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./hosts/guts/home.nix;
          home-manager.extraSpecialArgs = extraSpecialArgs;
        }
      ];
    };
  };
}
