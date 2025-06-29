{ ... }:
{
  imports = [
    ./shells/nushell.nix
    ./shells/zsh.nix

    ./monitoring/btop.nix

    ./tools/bat.nix
    ./tools/eza.nix
    ./tools/starship.nix
    ./tools/tmux.nix
    ./tools/yazi.nix
    ./tools/zoxide.nix
  ];
}
