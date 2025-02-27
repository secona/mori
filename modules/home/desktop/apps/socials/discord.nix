{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.socials.discord = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.socials.discord.enable {
    home.packages = [pkgs.discord];
  };
}
