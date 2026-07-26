{
  xdg.configFile."uwsm/env".text = ''
    export XCURSOR_SIZE=24
    export LC_ALL=zh_TW.UTF-8
    export LANG=zh_TW.UTF-8
    export QT_QPA_PLATFORMTHEME=qt6ct
    export SDL_VIDEODRIVER=wayland
    export GTK_IM_MODULE=wayland
    export XIM_MODULE=@im=fcitx
  '';

  wayland.windowManager.hyprland.systemd.enable = false;

  programs.noctalia.systemd.enable = true;
  programs.noctalia.settings.shell.launch_apps_as_systemd_services = true;
}
