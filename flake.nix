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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nixos hardware for hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # catppuccin for ricing
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    # home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim for configuring neovim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # NUR
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, nur, ... }@inputs:
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
          nur.overlays.default
        ];
      };

      hosts =
        ./hosts
        |> builtins.readDir
        |> builtins.attrNames
        |> builtins.foldl' (
          acc: hostName:
          acc
          // {
            nixosConfigurations = acc.nixosConfigurations // {
              ${hostName} = nixpkgs.lib.nixosSystem (
                import (./hosts + "/${hostName}/default.nix") {
                  inherit inputs pkgs;
                  hostName = hostName;
                }
              );
            };
          }
        ) { nixosConfigurations = { }; };
    in
    hosts
    // {
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
