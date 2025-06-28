{ ... }:
{
  imports = [
    ./editors/nvim
    ./editors/cursor.nix
    ./editors/helix.nix
    ./editors/vscode.nix
    ./editors/idea-ultimate.nix
    ./editors/zed-editor.nix

    ./tools/bruno.nix
    ./tools/burpsuite.nix
    ./tools/devenv.nix
    ./tools/direnv.nix
    ./tools/git.nix
    ./tools/jujutsu.nix
    ./tools/lazygit.nix
    ./tools/postman.nix
    ./tools/wireshark.nix
  ];
}
