{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.socials.beeper = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.socials.beeper.enable {
    home.packages = [pkgs.beeper];
  };
}
