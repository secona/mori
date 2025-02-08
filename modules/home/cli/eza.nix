{
  lib,
  config,
  ...
}: {
  options.cli.eza = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.cli.eza.enable {
    programs.eza = {
      enable = true;
      colors = "always";
      icons = "always";
    };
  };
}
