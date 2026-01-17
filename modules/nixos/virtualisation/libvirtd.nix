{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.nixos.virtualisation.libvirtd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.virtualisation.libvirtd.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
