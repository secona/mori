{
  lib,
  config,
  ...
}: {
  options.apps.yazi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.yazi.enable {
    programs.yazi = {
      enable = true;
    };
  };
}
