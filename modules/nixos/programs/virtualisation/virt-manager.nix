{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.virtualisation.virt-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.virtualisation.virt-manager.enable {
    programs.virt-manager.enable = true;
  };
}
