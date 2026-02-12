{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.browsers.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.browsers.firefox.enable {
    xdg.mimeApps = {
      defaultApplications = {
        "application/xhtml+xml" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "x-scheme-handler/webcal" = "firefox.desktop";
      };
    };

    catppuccin.firefox.profiles = {
      default = {
        force = true;
      };
    };

    programs.firefox =
      let
        extensionPackages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];

        extensionSettings = {
          "uBlock0@raymondhill.net".settings = {
            selectedFilterLists = [
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-unbreak"
              "ublock-quick-fixes"
            ];
          };
        };
      in
      {
        enable = true;
        profiles = {
          default = {
            id = 0;
            name = "default";
            extensions = {
              force = true;
              packages = extensionPackages;
              settings = extensionSettings;
            };
          };
        };
      };
  };
}
