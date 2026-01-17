{ ... }:
{
  imports = [
    ./games/steam.nix
    ./shells/fish.nix
    ./shells/zsh.nix
    ./misc/dconf.nix
    ./misc/nix-ld.nix
    ./wms/niri.nix
    ./virtualisation/virt-manager.nix
    ./tools/wireshark.nix
  ];
}
