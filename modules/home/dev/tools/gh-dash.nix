{
  lib,
  config,
  ...
}:
{
  options.dev.tools.gh-dash = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.gh-dash.enable {
    programs.gh = {
      enable = true;
    };

    programs.gh-dash = {
      enable = true;
    };
  };
}
