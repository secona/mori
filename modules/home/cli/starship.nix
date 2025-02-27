{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cli.starship = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.starship.enable {
    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../../../config/starship.toml;
    };
  };
}
