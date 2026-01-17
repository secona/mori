{
  lib,
  config,
  ...
}:
{
  options.nixos.programs.tools.wireshark = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.tools.wireshark.enable {
    programs.wireshark.enable = true;
  };
}
