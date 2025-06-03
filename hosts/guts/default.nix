{ inputs, pkgs, ... }: {
  system = "x86_64-linux";

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

