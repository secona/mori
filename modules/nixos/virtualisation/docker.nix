{
  lib,
  config,
  ...
}:
{
  options.nixos.virtualisation.docker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.virtualisation.docker.enable {
    virtualisation.docker.enable = true;
  };
}
