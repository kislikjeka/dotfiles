{ pkgs, ... }:

{
  enable = true;

  aggressiveResize = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  newSession = true;
  secureSocket = true;
  # shell = "${pkgs.fish}/bin/fish";
  shortcut = "a";
  terminal = "screen-256color";

  plugins = with pkgs.tmuxPlugins; [
    sensible
    vim-tmux-navigator
    {
      plugin = resurrect;
      extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    }
    {
      plugin = continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '60' # minutes
      '';
    }
    ];

  extraConfig = ''
    set -g default-terminal "tmux-256color"
    set-option -ga terminal-overrides ',xterm-256color:Tc'
    set -as terminal-features ",xterm-256color:RGB"
    set -g mouse on

    set-option -g allow-passthrough on

    # Start windows and panes at 1, not 0
    set -g base-index 1
    set -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on
    set-option -g set-titles on

    bind c new-window -c "#{pane_current_path}"

    bind q kill-pane
    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    bind -n M-Left resize-pane -L 5
    bind -n M-Right resize-pane -R 5
    bind -n M-Up resize-pane -U 5
    bind -n M-Down resize-pane -D 5

    bind -n M-l next-window
    bind -n M-h previous-window
    bind -n M-w command-prompt -I "#W" "rename-window '%%'"

    # set vi-mode
    set-window-option -g mode-keys vi

    # keybindings
    bind -n M-[ copy-mode
    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind P paste-buffer
    bind -T copy-mode-vi Escape send-keys -X cancel


    # Session.
    bind -n M-r command-prompt -I "#S" "rename-session '%%'"

    # Message style.
    set -g message-style "fg=yellow,bg=black"
    set -g message-command-style "fg=yellow,bg=black"

    # Pane style.
    set -g pane-border-style "fg=black"
    set -g pane-active-border-style "fg=black"

    # Status style.
    set -g status-style "fg=yellow,bg=black"
    set -g status-left "#[fg=cyan,bg=black]#[fg=black,bg=cyan] #{session_windows}#[fg=cyan,bg=black]  "
    set -g status-right "#[fg=colour8,bg=black] #S #[fg=green,bg=black] #[fg=black,bg=green]󱫋 #{session_attached}#[fg=green,bg=black]"
    set -g status-left-length 100
    set -g status-position top
    set -g status-justify left

    # Window style.
    set -g window-status-style "fg=colour8,bg=black"
    set -g window-status-format "#[fg=default,bg=black] #[fg=default,bg=black]#W"
    set -g window-status-separator "  "
    set -g window-status-current-format "#[fg=cyan,bg=black] #[fg=cyan,bg=black]#W"
  '';
}
