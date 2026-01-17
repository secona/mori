{
  lib,
  config,
  ...
}:
{
  options.nixos.services.xserver = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.services.xserver.enable {
    services.xserver = {
      enable = true;

      videoDrivers = [ "nvidia" ];

      xkb = {
        layout = "us";
        model = "pc105";
        variant = "";
      };
    };
  };
}
