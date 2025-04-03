{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.media.obs-studio = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
