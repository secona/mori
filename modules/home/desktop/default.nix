{...}: {
  imports = [
    ./browsers/google-chrome.nix

    ./docs/libreoffice.nix
    ./docs/xournalpp.nix
    ./docs/zathura.nix

    ./files/nemo.nix

    ./media/miru.nix
    ./media/obs-studio.nix
    ./media/vlc.nix

    ./misc/jflap.nix
    ./misc/octave.nix

    ./socials/discord.nix
    ./socials/beeper.nix
    ./socials/zoom-us.nix

    ./terminals/kitty.nix
    ./terminals/ghostty.nix

    ./games/minecraft.nix

    ./ui/catppuccin.nix

    ./wms/hypr.nix
    ./wms/river.nix
    ./wms/sway.nix
  ];
}
