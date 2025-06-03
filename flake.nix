{
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
  };

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

  outputs =
    { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
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

      hosts = let
        hostEntries = builtins.readDir ./hosts;
      in hostEntries
        |> builtins.attrNames
        |> builtins.filter (name: hostEntries.${name} == "directory")
        |> map (hostName: {
          name = hostName;
          value = nixpkgs.lib.nixosSystem (
            import (./hosts + "/${hostName}/default.nix") {
              inherit inputs pkgs;
              hostName = hostName;
            }
          );
        })
        |> builtins.listToAttrs;
    in
    {
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
      nixosConfigurations = hosts;
    };
}
