{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.files.dolphin = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.files.dolphin.enable {
    home.packages = with pkgs; [ kdePackages.dolphin ];
  };
}
