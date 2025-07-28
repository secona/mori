{ ... }:
{
  imports = [
    ./misc/fastfetch.nix

    ./shells/nushell.nix
    ./shells/zsh.nix

    ./monitoring/btop.nix

    ./tools/bat.nix
    ./tools/carapace.nix
    ./tools/eza.nix
    ./tools/starship.nix
    ./tools/tmux.nix
    ./tools/yazi.nix
    ./tools/zoxide.nix
  ];
}
