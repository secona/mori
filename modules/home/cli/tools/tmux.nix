{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.cli.tools.tmux = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.cli.tools.tmux.enable {
    programs.tmux = {
      enable = true;

      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      terminal = "tmux-256color";
      shell = "${pkgs.zsh}/bin/zsh";
      mouse = true;

      extraConfig = ''
        set -gq allow-passthrough on
        set -g visual-activity off

        setw -g monitor-activity on

        # Shift + Alt
        bind-key -n M-H resize-pane -L
        bind-key -n M-J resize-pane -D
        bind-key -n M-K resize-pane -U
        bind-key -n M-L resize-pane -R

        # Control + Alt
        bind-key -n C-M-l next-window
        bind-key -n C-M-h previous-window

        unbind -n M-h
        unbind -n M-l

        bind-key v split-window -v -c "#{pane_current_path}"
        bind-key h split-window -h -c "#{pane_current_path}"
      '';

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-save-interval 15
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
        sensible
        vim-tmux-navigator
      ];
    };

    catppuccin.tmux = {
      extraConfig = ''
        set -g window-status-format '#[fg=#6c7086]#I #[default]#{pane_current_command}'
        set -g window-status-current-format '#[bold]#[fg=#f5e0dc]#I:#W #[fg=#94e2d5]#{pane_current_command}'
      '';
    };
  };
}
