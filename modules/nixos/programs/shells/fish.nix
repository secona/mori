{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.shells.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.shells.fish.enable {
    programs.fish.enable = true;
  };
}
