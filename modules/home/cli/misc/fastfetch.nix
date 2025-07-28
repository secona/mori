{
  lib,
  config,
  ...
}:
{
  options.cli.misc.fastfetch = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.misc.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
    };
  };
}
