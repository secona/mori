{lib, config, ...}: {
  options.cli.bat  = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.cli.bat.enable {
    programs.bat = {
      enable = true;
    };
  };
}
