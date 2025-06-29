{
  lib,
  config,
  ...
}:
{
  options.cli.monitoring.btop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.monitoring.btop.enable {
    programs.btop = {
      enable = true;
    };
  };
}
