{
  pkgs,
  lib,
  config,
  ...
}: {
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
        set -g @catppuccin_window_number_position "left"
        set -g @catppuccin_window_current_number_color "#{@thm_green}"
        set -g @catppuccin_window_text ""
        set -g @catppuccin_window_number "#[bold]Tab ###I "
        set -g @catppuccin_window_current_text ""
        set -g @catppuccin_window_current_number "#[bold]Tab ###I "
        set -g @catppuccin_window_status_style "custom"
        set -g @catppuccin_window_right_separator "#[fg=#{@_ctp_status_bg},reverse]#[none]"

        set -g @catppuccin_window_left_separator "#[fg=#{@_ctp_status_bg}] #[none]"
        set -g @catppuccin_window_middle_separator "#[bg=#{@catppuccin_window_text_color},fg=#{@catppuccin_window_number_color}]"
        set -g @catppuccin_window_current_middle_separator "#[bg=#{@catppuccin_window_current_text_color},fg=#{@catppuccin_window_current_number_color}]"

        set -g window-status-separator ""
        set -g status-left-length 0
        set -g status-left "#[fg=#{@thm_fg} bold]TMUX (#S) "
        set -ga status-left "#{?client_prefix,#[fg=#{@thm_red} bold]PREFIX ,#{?#{==:#{pane_mode},copy-mode},#[fg=#{@thm_yellow} bold]COPY ,#[fg=#{@thm_green} bold]NORMAL }}"
        set -g status-right ""
      '';
    };
  };
}
