{
  lib,
  config,
  ...
}:
{
  options.nixos.services.printing = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.services.printing.enable {
    services.printing.enable = true;
  };
}
