{
  lib,
  config,
  ...
}:
{
  options.nixos.services.postgresql = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.services.postgresql.enable {
    services.postgresql.enable = true;
  };
}
