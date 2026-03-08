{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    hyprland-qtutils
    hyprland-qt-support
    hyprcursor
    hyprpicker
    hyprutils
    hyprwayland-scanner
  ];

  services.hypridle.enable = true;
  services.hyprsunset.enable = true;
  programs.hyprlock.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ pkgs.hyprlandPlugins.hyprscrolling ];
    settings =
      let
        inherit (lib) getExe getExe';
        noctaliactl = "noctalia-shell ipc call";
      in
      {
        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor = ",preferred,auto,auto,bitdepth,10";
        exec-once = [
          "noctalia-shell"
          "fcitx5"
          # "krunner -d"
          "${getExe pkgs.dex} -as ~/.config/autostart"
          "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
          "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init"
          (getExe' pkgs.swww "swww-daemon")
        ];
        env = [
          # Nvidia
          # "GBM_BACKEND,nvidia-drm"
          # "LIBVA_DRIVER_NAME,nvidia"
          # "__GLX_VENDOR_LIBRARY_NAME,nvidia"

          # "XDG_CURRENT_DESKTOP,KDE"
          "QT_QPA_PLATFORM,wayland"
          "QT_QPA_PLATFORMTHEME,qt5ct" # Hyprland doesn't load ~/.config/environment.d/ for some reason
          "XCURSOR_SIZE,24"
          "LC_ALL,zh_TW.UTF-8"
          "LANG,zh_TW.UTF-8"
          "SDL_VIDEODRIVER=wayland"
          "GTK_IM_MODULE=wayland"
          # "QT_IM_MODULE=fcitx"
          "XIM_MODULE=@im=fcitx"
        ];
        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/

        debug = {
          disable_logs = false;
        };
        input = {
          # See /usr/share/X11/xkb/rules/base.lst
          kb_layout = "us";
          # kb_variant = "colemak_dh";

          follow_mouse = 0;

          touchpad.natural_scroll = false;
          sensitivity = 0;

          numlock_by_default = true;
        };
        cursor = {
          no_hardware_cursors = true;
        };
        general = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          layout = "scrolling";
        };
        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          shadow = {
            enabled = true; # previously `drow_shadow`
            range = 4;
            render_power = 3;
            color = "0xee1a1a1a";
          };
        };
        animations = {
          enabled = true;

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        windowrule = [
          "fullscreen on, match:class ^(osu!)$, match:title ^(osu!)$"
          "fullscreen on, match:class ^(fl64.exe)$, match:initial_title ^(FL Studio)$"
          "no_anim on, float on, move 0 0, no_initial_focus on, match:title ^(flameshot)$"
        ];

        layerrule = [
          {
            name = "noctalia";
            "match:namespace" = "noctalia-background-.*$";
            ignore_alpha = 0.5;
            blur = true;
            blur_popups = true;
          }
        ];

        plugin.hyprscrolling = {
          column_width = 0.7;
          fullscreen_on_one_column = true;
        };

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        "$mainMod" = "SUPER";
        bind =
          let
            inherit (lib.lists) flatten range;
          in
          [
            "$mainMod, Q, exec, ghostty"
            "$mainMod, C, killactive"
            "$mainMod, M, exit"
            "$mainMod, E, exec, dolphin"
            "$mainMod, V, togglefloating"
          ]
          ++ flatten (
            map (key: "${key}, exec, ${noctaliactl} launcher toggle") [
              "$mainMod, R"
              "ALT, space"
            ]
          )
          ++ [
            "$mainMod, S, exec, ${noctaliactl} controlCenter toggle"
            "$mainMod, F, fullscreen,"
            "$mainMod, L, exec, wlogout"
            ", Print, exec, XDG_CURRENT_DESKTOP=sway flameshot gui"
            # Move focus with mainMod + arrow keys
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"
          ]
          ++ flatten (
            map (
              ws:
              let
                key = toString (lib.trivial.mod ws 10);
              in
              [
                # Switch workspaces with mainMod + [0-9]
                "$mainMod, ${key}, workspace, ${toString ws}"
                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, ${key}, movetoworkspace, ${toString ws}"
              ]
            ) (range 1 10)
          )
          ++ [
            # Scroll through existing workspaces with mainMod + scroll
            "$mainMod CTRL, mouse_up, workspace, +1"
            "$mainMod CTRL, mouse_down, workspace, -1"
            "$mainMod, mouse_up, layoutmsg, move +col"
            "$mainMod, mouse_down, layoutmsg, move -col"

            # "$mainMod SHIFT CTRL, mouse_up, movetoworkspace, +1"
            # "$mainMod SHIFT CTRL, mouse_down, movetoworkspace, -1"
            "$mainMod SHIFT, mouse_up, layoutmsg, movewindowto r"
            "$mainMod SHIFT, mouse_down, layoutmsg, movewindowto l"

            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPauce, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"
            ", XF86AudioNext, exec, playerctl next"
          ];
        bindl = [
          ", XF86AudioMute, exec, ${noctaliactl} volume muteOutput"
        ];
        bindel = [
          ", XF86AudioRaiseVolume, exec, ${noctaliactl} volume increase"
          ", XF86AudioLowerVolume, exec, ${noctaliactl} volume decrease"
          ", XF86MonBrightnessUp, exec, ${noctaliactl} brightness increase"
          ", XF86MonBrightnessDown, exec, ${noctaliactl} brightness decrease"
        ];
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
  };
}
