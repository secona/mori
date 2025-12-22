{
  lib,
  config,
  ...
}:
{
  options.cli.tools.delta = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.delta.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
      };
    };
  };
}
