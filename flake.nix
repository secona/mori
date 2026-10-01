{
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
    # both stable branch and unstable branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nixos hardware for hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # catppuccin for ricing
    catppuccin.url = "github:catppuccin/nix/v26.05";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    # home manager
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim for configuring neovim
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";

    # NUR
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    # flake-parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # formatting
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    # coding agents
    llm-agents.url = "github:numtide/llm-agents.nix";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        inputs.treefmt-nix.flakeModule
        ./hosts/default.nix
      ];

      perSystem = {
        treefmt.programs = {
          nixfmt.enable = true;
        };
      };
    };
}
