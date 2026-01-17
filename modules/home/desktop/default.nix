{ ... }:
{
  imports = [
    ./browsers/firefox.nix
    ./browsers/google-chrome.nix

    ./docs/libreoffice.nix
    ./docs/xournalpp.nix
    ./docs/zathura.nix
    ./docs/zotero.nix

    ./files/nemo.nix

    ./launcher/wofi.nix

    ./media/davinci-resolve.nix
    ./media/flameshot.nix
    ./media/miru.nix
    ./media/obs-studio.nix
    ./media/spotify-player.nix
    ./media/vlc.nix

    ./misc/anki.nix
    ./misc/cisco-packet-tracer.nix
    ./misc/jflap.nix
    ./misc/octave.nix

    ./notifications/dunst.nix
    ./notifications/swaync.nix

    ./socials/discord.nix
    ./socials/beeper.nix
    ./socials/zoom-us.nix

    ./status-bar/eww.nix
    ./status-bar/i3status-rust.nix

    ./terminals/kitty.nix
    ./terminals/ghostty.nix

    ./games/minecraft.nix

    ./launcher/wofi.nix

    ./ui/catppuccin.nix
    ./ui/gtk.nix

    ./utils/ctl.nix
    ./utils/wlogout.nix

    ./wms/hyprland.nix
    ./wms/river.nix
    ./wms/sway.nix
  ];
}
