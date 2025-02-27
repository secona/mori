{
  lib,
  config,
  ...
}: {
  options.apps.zathura = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
