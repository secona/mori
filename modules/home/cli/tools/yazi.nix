{
  lib,
  config,
  ...
}:
{
  options.cli.tools.yazi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.yazi.enable {
    programs.yazi = {
      enable = true;
    };
  };
}
