{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.socials.discord = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.socials.discord.enable {
    home.packages = [pkgs.discord];
  };
}
