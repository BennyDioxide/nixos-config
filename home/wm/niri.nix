{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) getExe;

  wpctl = lib.getExe' pkgs.wireplumber "wpctl";
in
{
  imports = [ inputs.niri.homeModules.niri ];

  home.packages = [ pkgs.xwayland-satellite-stable ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-stable;
  programs.niri.settings = {
    environment = {
      QT_QPA_PLATFORM = "wayland";
      # DISPLAY = null;
      GTK_IM_MODULE = "wayland";
      XIM_MODULE = "@im=fcitx";
    };
    spawn-at-startup = [
      # { command = [ "krunner" "-d" ]; }
      { command = [ (getExe pkgs.fcitx5) ]; }
    ];
    binds = with config.lib.niri.actions; {
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+T".action = spawn (getExe pkgs.kitty);
      "Mod+D".action = spawn (getExe pkgs.fuzzel); # "krunner";
      "Super+Alt+L".action = spawn (getExe pkgs.swaylock);

      "XF86AudioRaiseVolume".action.spawn = [
        wpctl
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.02+"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        wpctl
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.02-"
      ];
      "XF86AudioMute".allow-when-locked = true;
      "XF86AudioMute".action.spawn = [
        wpctl
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];

      "Mod+Q".action = close-window;

      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;

      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+Up".action = move-window-up;
      "Mod+Ctrl+Down".action = move-window-down;

      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;

      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Shift+Page_Down".action = move-workspace-down;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      "Mod+R".action = switch-preset-column-width;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+C".action = center-column;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Plus".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Plus".action = set-window-height "+10%";

      "Print".action = screenshot;
      # "Ctrl+Print".action = screenshot-screen;
      "Alt+Print".action = screenshot-window;

      "Mod+Shift+E".action = quit;
      "Mod+Shift+P".action = power-off-monitors;
    };

  };
}
