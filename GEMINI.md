# Mori: NixOS Configuration

Mori (森) is a modular NixOS configuration based on Nix Flakes and Home Manager. It is designed to be highly customizable, aesthetically pleasing (using Catppuccin), and developer-friendly.

## Project Structure

- `flake.nix`: Entry point for the configuration, defines inputs and flake-parts structure.
- `hosts/`: Contains machine-specific configurations.
    - `default.nix`: Dynamically discovers and exports all host configurations.
    - `<hostname>/`: Each host has its own directory with `default.nix`, `configuration.nix`, `hardware-configuration.nix`, and `users/`.
- `modules/`: Contains reusable NixOS and Home Manager modules.
    - `home/`: Home Manager modules categorized by function (cli, dev, desktop).
- `config/`: Contains non-Nix configuration files (e.g., Starship, Eww, SwayNC) that are managed by Nix.
- `wallpapers/`: A collection of wallpapers used in the configuration.
- `shells/`: Project-specific development shells.

## Development & Maintenance

### Formatting
Format the codebase using:
```bash
nix fmt
```

### Adding Packages

By default, packages should be added to `modules/home` following the structure laid out.

## Git

### Commit Messages

This project follows a specific commit message convention:

**Format:** `[scope][scope] message`

- **Scope**: The module, tool, host, user, or component being modified (e.g., `nvim`, `starship`, `hyprland`, `flake`, `okami`).
- **Message**: Concise, lowercase, and imperative description of the change.

**Examples:**
- `[nvim] fix mini.pick`
- `[starship] fix jj custom`
- `[starship] add jj`
- `[nvim] use mini.nvim`
- `[nvim] evil lualine`
- `[okami][secona] change git username`
- `[docs] add GEMINI.md file`

### Workflow

Use atomic commits.

- **Separation**: Define a module and enable it in separate commits.
  - *Example*:
    - `[foo] init`
    - `[okami][secona] enable foo`

## Conventions

- **Modularization**: Keep modules atomic. Each module should handle one tool or set of related tools.
- **Options**: Use `lib.mkEnableOption` and `lib.mkIf` to make modules toggleable.
- **Paths**: Use relative paths where possible within modules.
- **Unstable Packages**: Access unstable packages via `pkgs.unstable.<package>` (provided by an overlay).
