{
  lib,
  config,
  ...
}:
{
  options.cli.tools.carapace = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.carapace.enable {
    programs.carapace = {
      enable = true;
    };
  };
}
