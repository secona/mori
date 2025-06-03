{
  lib,
  config,
  ...
}:
{
  options.dev.tools.lazygit = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.lazygit.enable {
    home.shellAliases.lg = "lazygit";

    programs.lazygit = {
      enable = true;
    };
  };
}
