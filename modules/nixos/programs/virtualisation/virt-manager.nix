{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.virt-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.virt-manager.enable {
    programs.virt-manager.enable = true;
  };
}
