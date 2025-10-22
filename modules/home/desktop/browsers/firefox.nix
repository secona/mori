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
