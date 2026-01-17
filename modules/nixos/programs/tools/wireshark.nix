{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.wireshark = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.wireshark.enable {
    programs.wireshark.enable = true;
  };
}
