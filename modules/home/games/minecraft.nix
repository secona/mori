{
  pkgs,
  lib,
  config,
  ...
}: {
  options.games.minecraft = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.games.minecraft.enable {
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
