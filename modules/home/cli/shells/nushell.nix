{
  lib,
  config,
  ...
}:
{
  options.cli.shells.nushell = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.shells.nushell.enable {
    home.shell.enableNushellIntegration = true;

    programs.nushell = {
      enable = true;
    };
  };
}
