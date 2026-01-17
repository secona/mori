{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.fish.enable {
    programs.fish.enable = true;
  };
}
