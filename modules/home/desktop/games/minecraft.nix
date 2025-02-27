{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.games.minecraft = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.games.minecraft.enable {
    home.packages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          jdk17
          jdk
        ];
      })
    ];
  };
}
