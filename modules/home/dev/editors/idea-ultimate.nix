{
  pkgs,
  lib,
  config,
  ...
}: {
  options.dev.editors.idea-ultimate = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.editors.idea-ultimate.enable {
    home.packages = [
      # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate [
      #   "ideavim"
      # ])
      pkgs.jetbrains.idea-ultimate
    ];
  };
}
