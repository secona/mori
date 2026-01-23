{
  lib,
  config,
  ...
}:
{
  options.nixos.services.zerotierone = {
    enable = lib.mkEnableOption "zerotierone";
  };

  config = lib.mkIf config.nixos.services.zerotierone.enable {
    services.zerotierone.enable = true;
  };
}
