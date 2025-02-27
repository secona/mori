{...}: {
  imports = [
    ./apps/browsers/google-chrome.nix
    ./apps/docs/libreoffice.nix
    ./apps/docs/xournalpp.nix
    ./apps/docs/zathura.nix
    ./apps/media/miru.nix
    ./apps/media/vlc.nix
    ./apps/misc/jflap.nix
    ./apps/misc/octave.nix
    ./apps/socials/discord.nix
    ./apps/socials/zoom-us.nix
    ./apps/terminals/kitty.nix
    ./apps/terminals/ghostty.nix

    ./games/minecraft.nix

    ./ui/catppuccin.nix

    ./wms/hypr.nix
    ./wms/river.nix
    ./wms/sway.nix
  ];
}
