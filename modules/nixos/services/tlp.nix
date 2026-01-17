{
  lib,
  config,
  ...
}:
{
  options.nixos.services.tlp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.services.tlp.enable {
    services.tlp.enable = true;
  };
}
