{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.misc.octave = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.misc.octave.enable {
    home.packages = with pkgs; [octaveFull];
  };
}
