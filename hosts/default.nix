{ inputs, ... }:
{
  flake.nixosConfigurations =
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
    in
    ./.
    |> builtins.readDir
    |> builtins.attrNames
    |> builtins.filter (name: name != "default.nix")
    |> builtins.foldl' (
      acc: hostName:
      acc
      // {
        ${hostName} = inputs.nixpkgs.lib.nixosSystem (
          import (./. + "/${hostName}/default.nix") {
            inherit inputs pkgs;
            hostName = hostName;
          }
        );
      }
    ) { };
}
