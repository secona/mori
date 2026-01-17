{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.shells.zsh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.shells.zsh.enable {
    programs.zsh.enable = true;
  };
}
