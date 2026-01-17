{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.nixos.services.plasma6 = {
    enable = lib.mkEnableOption "Plasma 6 Desktop Environment";
  };

  config = lib.mkIf config.nixos.services.plasma6.enable {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kate
      kdePackages.dolphin
      kdePackages.konsole
      kdePackages.ark
      kdePackages.gwenview
    ];
  };
}
