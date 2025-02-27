{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.misc.octave = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.misc.octave.enable {
    home.packages = with pkgs; [octaveFull];
  };
}
