{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.tools.postman = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.postman.enable {
    home.packages = [ pkgs.postman ];
  };
}
