{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.nixos.programs.tools.openvpn = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.tools.openvpn.enable {
    environment.systemPackages = [ pkgs.openvpn ];
  };
}
