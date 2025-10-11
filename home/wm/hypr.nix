{
  lib,
  pkgs,
  inputs,
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

  xdg.configFile =
    lib.genAttrs'
      [
        "hypridle.conf"
        "hyprlock.conf"
        "hyprlock/check-capslock.sh"
        "hyprlock/colors.conf"
        "hyprlock/status.sh"
      ]
      (
        s:
        let
          file = "hypr/${s}";
        in
        lib.nameValuePair file { source = "${inputs.end-4_dots-hyprland}/.config/${file}"; }
      );

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ pkgs.hyprlandPlugins.hyprscrolling ];
    settings =
      let
        inherit (lib) getExe getExe';
      in
      {
        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor = ",preferred,auto,auto,bitdepth,10";
        exec-once = [
          "${getExe pkgs.quickshell} --config end4-ii"
          (getExe pkgs.fcitx5)
          # "krunner -d"
          "${getExe pkgs.dex} -as ~/.config/autostart"
          "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
          "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init"
          (getExe' pkgs.swww "swww-daemon")
        ];
        env = [
          # Nvidia
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct" # nvidia-vaapi-driver

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

          follow_mouse = 1;

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

        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
        };

        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          # new_is_master = true;
        };

        gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
        };

        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        windowrule = [
          "fullscreen,class:^(osu!)$,title:^(osu!)$"
          "fullscreen,class:^(fl64.exe)$,initialTitle:^(FL Studio)$"
          "noanim, title:^(flameshot)$"
          "float, title:^(flameshot)$"
          "move 0 0, title:^(flameshot)$"
          "pin, title:^(flameshot)$"
          "noinitialfocus, title:^(flameshot)$"
        ];

        plugin.hyprscrolling = {
          column_width = 0.7;
          fullscreen_on_one_column = true;
        };

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        "$mainMod" = "SUPER";
        bind =
          with lib.lists;
          [
            "$mainMod, Q, exec, kitty"
            "$mainMod, C, killactive"
            "$mainMod, M, exit"
            "$mainMod, E, exec, dolphin"
            "$mainMod, V, togglefloating"
          ]
          ++ flatten (
            # map (key: "${key}, exec, nu -c \"GTK_IM_MODULE=fcitx anyrun\"") [
            map (key: "${key}, exec, ${getExe pkgs.fuzzel}") [
              "$mainMod, R"
              "ALT, space"
            ]
          )
          ++ [
            "$mainMod, P, pseudo," # dwindle
            "$mainMod, J, togglesplit," # dwindle
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

            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPauce, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"
            ", XF86AudioNext, exec, playerctl next"
          ];
        binde = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
        ];
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
  };
}
