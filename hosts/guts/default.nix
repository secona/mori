{
  inputs,
  pkgs,
  hostName,
  ...
}:
{
  system = "x86_64-linux";

  specialArgs = {
    inherit pkgs hostName;
  };

  modules = [
    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-hardware.nixosModules.lenovo-ideapad-15ach6

    {
      home-manager.extraSpecialArgs = {
        inherit inputs pkgs;
      };
    }
  ];
}
