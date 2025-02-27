{
  lib,
  config,
  ...
}: {
  options.cli.tools.zoxide = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.zoxide.enable {
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };
}
