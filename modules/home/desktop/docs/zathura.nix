{
  lib,
  config,
  ...
}:
{
  options.desktop.docs.zathura = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.docs.zathura.enable {
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
    };

    programs.zathura = {
      enable = true;
    };
  };
}
