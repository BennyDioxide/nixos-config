{ ... }:

{
  programs.tmux = {
    enable = true;
    plugins = [
      {
        plugin = (import ../pkgs/tmux-plugins).pomodoro-plus;
        extraConfig = ''
          set -g @pomodoro_notifications 'on'
          set -g @pomodoro_sound 'on'
        '';
      }
    ];
    extraConfig = ''
      unbind r
      bind r source-file ~/.tmux.conf

      set -g prefix C-s

      setw -g mode-keys vi
      setw -g mouse on
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

    '';
  };
}
