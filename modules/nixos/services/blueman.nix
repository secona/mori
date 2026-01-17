{
  lib,
  config,
  ...
}:
{
  options.nixos.services.blueman = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.services.blueman.enable {
    services.blueman.enable = true;
  };
}
