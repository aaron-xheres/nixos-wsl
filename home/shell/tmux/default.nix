{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      { 
        plugin = onedark-theme;
        extraConfig = ''
          set -g @onedark_date_format "%a, %d/%m/%Y"
        '';
      }
    ];
    extraConfig = ''
      # --- Keybinds ---
      # Prefix
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      # Split Pane
      unbind '"'
      unbind %
      bind h split-window -h
      bind v split-window -v
      
      # Pane Movement
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R

      # Session
      unbind c
      unbind p
      unbind n
      bind t new-window
      bind c kill-window

      # Session Movement
      unbind (
      unbind )
      bind -n M-] switch-client -n
      bind -n M-[ switch-client -p

      # Reload Config
      bind r source-file ~/.config/tmux/tmux.conf

      # --- Options ---
      set-option -g allow-rename off

      # --- Appearance ---
      set -g pane-active-border-style 'fg=yellow'
    '';
  };
}
