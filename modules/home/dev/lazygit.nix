{
  lib,
  config,
  ...
}: {
  options.dev.lazygit = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.dev.lazygit.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
