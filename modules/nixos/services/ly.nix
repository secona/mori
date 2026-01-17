{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.nixos.services.ly = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.services.ly.enable {
    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
        };
      };
      sessionPackages = with pkgs; [ sway ];
    };
  };
}
