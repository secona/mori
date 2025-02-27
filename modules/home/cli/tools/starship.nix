{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cli.tools.starship = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.starship.enable {
    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../../../../config/starship.toml;
    };
  };
}
