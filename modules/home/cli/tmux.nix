{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cli.tmux = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.cli.tmux.enable {
    programs.tmux = {
      enable = true;

      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      terminal = "screen-256color";
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
  };
}
