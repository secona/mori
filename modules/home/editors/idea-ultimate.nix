{
  pkgs,
  lib,
  config,
  ...
}: {
  options.editors.idea-ultimate = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.editors.idea-ultimate.enable {
    home.packages = [pkgs.jetbrains.idea-ultimate];
  };
}
