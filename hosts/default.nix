{ inputs, ... }:
let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      })
      inputs.nur.overlays.default
    ];
  };

  hostsDir = ./.;
  hostNames = builtins.attrNames (builtins.removeAttrs (builtins.readDir hostsDir) [ "default.nix" ]);

  nixosHostNames = builtins.filter (
    name: builtins.pathExists (hostsDir + "/${name}/default.nix")
  ) hostNames;

  homeHostNames = builtins.filter (
    name:
    builtins.pathExists (hostsDir + "/${name}/home.nix")
    && !builtins.pathExists (hostsDir + "/${name}/default.nix")
  ) hostNames;

in
{
  flake.nixosConfigurations = builtins.listToAttrs (
    map (hostName: {
      name = hostName;
      value = inputs.nixpkgs.lib.nixosSystem (
        import (./. + "/${hostName}/default.nix") {
          inherit inputs pkgs;
          hostName = hostName;
        }
      );
    }) nixosHostNames
  );

  flake.homeConfigurations = builtins.listToAttrs (
    map (hostName: {
      name = hostName;
      value = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          (./. + "/${hostName}/home.nix")
        ];
      };
    }) homeHostNames
  );
}
