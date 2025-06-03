{
  lib,
  config,
  ...
}:
{
  options.desktop.utils.wlogout = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.utils.wlogout.enable {
    programs.wlogout = {
      enable = true;
    };
  };
}
