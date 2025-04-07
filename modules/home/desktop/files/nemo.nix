{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.media.nemo = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.nemo.enable {
    home.packages = with pkgs; [nemo];
  };
}
