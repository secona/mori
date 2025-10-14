{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.misc.cisco-packet-tracer = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.misc.cisco-packet-tracer.enable {
    home.packages = with pkgs; [ ciscoPacketTracer8 ];
  };
}
