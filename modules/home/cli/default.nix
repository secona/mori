{ ... }:
{
  imports = [
    ./shells/nushell.nix
    ./shells/zsh.nix

    ./tools/bat.nix
    ./tools/btop.nix
    ./tools/eza.nix
    ./tools/gh-dash.nix
    ./tools/starship.nix
    ./tools/tmux.nix
    ./tools/yazi.nix
    ./tools/zoxide.nix
  ];
}
