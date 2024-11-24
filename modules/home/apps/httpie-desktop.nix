{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.httpie-desktop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.httpie-desktop.enable {
    home.packages = with pkgs; [httpie-desktop];
  };
}
