{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.niri.enable {
    programs.niri.enable = true;
  };
}
