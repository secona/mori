{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.miru = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.miru.enable {
    home.packages = with pkgs; [miru];
  };
}
