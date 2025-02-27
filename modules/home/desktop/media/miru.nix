{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.media.miru = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.miru.enable {
    home.packages = with pkgs; [miru];
  };
}
