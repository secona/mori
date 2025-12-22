{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.media.davinci-resolve = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.davinci-resolve.enable {
    home.packages = [ pkgs.davinci-resolve ];
  };
}
