{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.misc.anki = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.misc.anki.enable {
    home.packages = with pkgs; [ anki ];
  };
}
