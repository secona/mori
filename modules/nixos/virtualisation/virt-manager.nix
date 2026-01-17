{
  lib,
  config,
  ...
}:
{
  options.nixos.virtualisation.virt-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.virtualisation.virt-manager.enable {
    programs.virt-manager.enable = true;
  };
}
