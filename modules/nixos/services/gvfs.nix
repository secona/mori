{
  lib,
  config,
  ...
}:
{
  options.nixos.services.gvfs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.services.gvfs.enable {
    services.gvfs.enable = true;
  };
}
