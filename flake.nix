{
  inputs = {
    # both stable branch and unstable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nixos hardware for hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # catppuccin for ricing
    catppuccin.url = "github:catppuccin/nix";

    # home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim for configuring neovim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            system = prev.system;
            config.allowUnfree = true;
          };
        })
      ];
    };
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations.guts = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/guts/configuration.nix
        home-manager.nixosModules.default
        nixos-hardware.nixosModules.lenovo-ideapad-15ach6
        {home-manager.extraSpecialArgs = {inherit pkgs inputs;};}
      ];
    };
  };
}
