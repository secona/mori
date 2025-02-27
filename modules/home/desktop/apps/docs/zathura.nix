{
  lib,
  config,
  ...
}: {
  options.desktop.apps.docs.zathura = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.docs.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
