{
  lib,
  config,
  pkgs,
  ...
}: {
  options.dev.editors.cursor = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.editors.cursor.enable {
    home.packages = [
      pkgs.unstable.code-cursor
    ];
  };
}
