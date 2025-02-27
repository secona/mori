{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.jflap = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.jflap.enable {
    home.packages = with pkgs; [jflap];
  };
}
