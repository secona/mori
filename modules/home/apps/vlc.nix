{pkgs, lib, config, ...}: {
  options.apps.vlc = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.vlc.enable {
    home.packages = [pkgs.vlc];
  };
}
