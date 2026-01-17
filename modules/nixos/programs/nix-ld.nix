{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.nix-ld = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.nix-ld.enable {
    programs.nix-ld.enable = true;
  };
}
