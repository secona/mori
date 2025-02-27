{
  lib,
  config,
  ...
}: {
  options.desktop.docs.zathura = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.docs.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
