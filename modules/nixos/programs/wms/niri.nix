{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.nixos.programs.wms.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.wms.niri.enable {
    programs.niri.enable = true;
    services.noctalia-shell.enable = true;

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
