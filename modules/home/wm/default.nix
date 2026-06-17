{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [
    # ./quickshell.nix
    ./noctalia.nix
    ./hypr
    # ./niri.nix
    ./flameshot.nix
  ];

  qt = {
    enable = !isDarwin;
    platformTheme.name = "qtct";
  };

  # Enables xembed system tray available on Wayland
  services.xembed-sni-proxy.enable = !isDarwin;

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    dex
    fuzzel
    awww
    wl-clipboard
    # xwayland-run
    grim
    slurp
    hyprpicker
    hyprcursor

    wayland-utils
    ydotool

    # For ags
    dart-sass
    libnotify
    gnome-usage
    brightnessctl

    kdePackages.breeze
    kdePackages.breeze-icons
  ];
}
