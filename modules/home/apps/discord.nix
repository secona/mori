{pkgs, lib, config, ...}: {
  options.apps.discord = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.discord.enable {
    home.packages = [pkgs.discord];
  };
}
