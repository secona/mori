{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.tools.zeal.enable = lib.mkEnableOption "Zeal offline documentation browser";

  config = lib.mkIf config.dev.tools.zeal.enable {
    home.packages = [ pkgs.zeal ];
  };
}
