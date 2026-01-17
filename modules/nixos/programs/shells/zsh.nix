{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.zsh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.zsh.enable {
    programs.zsh.enable = true;
  };
}
