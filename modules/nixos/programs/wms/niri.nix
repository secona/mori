{
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

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      swaybg
      waybar
    ];
  };
}
