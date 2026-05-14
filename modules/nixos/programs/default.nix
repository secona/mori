{ ... }:
{
  imports = [
    ./games/steam.nix
    ./shells/fish.nix
    ./shells/zsh.nix
    ./misc/dconf.nix
    ./misc/fcitx5.nix
    ./misc/nix-ld.nix
    ./wms/niri.nix
    ./tools/openvpn.nix
    ./tools/wireshark.nix
  ];
}
