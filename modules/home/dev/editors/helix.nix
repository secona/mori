{
  lib,
  config,
  ...
}:
{
  options.dev.editors.helix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.editors.helix.enable {
    programs.helix = {
      enable = true;
    };

    catppuccin.helix.useItalics = true;
  };
}
