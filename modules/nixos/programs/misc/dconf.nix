{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.misc.dconf = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.misc.dconf.enable {
    programs.dconf.enable = true;
  };
}
