{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.files.nemo = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.files.nemo.enable {
    home.packages = with pkgs; [ nemo-with-extensions ];
  };
}
