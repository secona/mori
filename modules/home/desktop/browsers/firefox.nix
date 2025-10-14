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

          person1 = {
            id = 1;
            name = "person1";
            extensions = {
              force = true;
              packages = extensionPackages;
              settings = extensionSettings;
            };
          };

          person2 = {
            id = 2;
            name = "person2";
            extensions = {
              force = true;
              packages = extensionPackages;
              settings = extensionSettings;
            };
          };

          person3 = {
            id = 3;
            name = "person3";
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
