{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.dconf = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.dconf.enable {
    programs.dconf.enable = true;
  };
}
