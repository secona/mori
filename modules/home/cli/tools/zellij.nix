{
  lib,
  config,
  ...
}:
{
  options.cli.tools.zellij = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.zellij.enable {
    programs.zellij = {
      enable = true;
      settings = {
        ui.pane_frames.rounded_corners = true;
      };
    };
  };
}
