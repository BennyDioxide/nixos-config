{ inputs, pkgs, ... }:

{
  imports = [
    ./hypr.nix
    # ./niri.nix
    inputs.ags.homeManagerModules.default
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
    ddcutil
    gnome-usage
    brightnessctl
  ];

  programs.ags = {
    enable = true;
    configDir = "${inputs.end-4_dots-hyprland}/.config/ags";
    extraPackages = with pkgs; [
      gtksourceview
      gtksourceview4
    ];
  };
}
