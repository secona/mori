{
  lib,
  config,
  ...
}: {
  options.cli.btop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.btop.enable {
    programs.btop = {
      enable = true;
    };
  };
}
