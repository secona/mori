{
  lib,
  config,
  ...
}:
{
  options.cli.tools.eza = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.eza.enable {
    programs.eza = {
      enable = true;
      colors = "always";
      icons = "always";
    };
  };
}
