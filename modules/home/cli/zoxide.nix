{
  lib,
  config,
  ...
}: {
  options.cli.zoxide = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.cli.zoxide.enable {
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };
}
