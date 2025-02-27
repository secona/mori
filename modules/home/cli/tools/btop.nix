{
  lib,
  config,
  ...
}: {
  options.cli.tools.btop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.btop.enable {
    programs.btop = {
      enable = true;
    };
  };
}
