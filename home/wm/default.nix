{ pkgs, ... }:

{
  imports = [
    ./quickshell.nix
    ./hypr.nix
    # ./niri.nix
    ./flameshot.nix
  ];

  home.packages = with pkgs; [
    fuzzel
    swww
    wl-clipboard
    # xwayland-run
    grim
    slurp
    hyprpicker
    hyprcursor

    # For ags
    dart-sass
    libnotify
    gnome-usage
    brightnessctl
  ];
}
