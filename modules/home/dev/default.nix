{...}: {
  imports = [
    ./editors/nvim
    ./editors/vscode.nix
    ./editors/idea-ultimate.nix

    ./tools/bruno.nix
    ./tools/direnv.nix
    ./tools/git.nix
    ./tools/lazygit.nix
    ./tools/postman.nix
  ];
}
