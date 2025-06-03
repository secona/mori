{
  pkgs,
  lib,
  config,
  ...
}: {
  options.dev.tools.wireshark = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.wireshark.enable {
    home.packages = [pkgs.wireshark];
  };
}
