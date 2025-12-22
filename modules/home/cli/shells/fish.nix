{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.cli.shells.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.shells.fish.enable {
    home.shell.enableFishIntegration = true;

    programs.fish = {
      enable = true;
    };
  };
}
