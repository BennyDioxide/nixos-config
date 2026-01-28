{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) end-4_dots-hyprland;
in
{
  home.packages =
    with pkgs.kdePackages;
    [
      kdialog
      qt5compat
      qtdeclarative
      qtimageformats
      qtmultimedia
      qtpositioning
      qtquicktimeline
      qtsensors
      qtsvg
      qttools
      qtvirtualkeyboard
      qtwayland
      syntax-highlighting
    ]
    ++ (with pkgs; [
      upower
      wtype
      ydotool
    ]);

  programs.quickshell = {
    enable = true;
    activeConfig = "end4-ii";
    configs = rec {
      end4-ii = "${end-4_dots-hyprland}/.config/quickshell/ii";
      default = end4-ii;
    };
  };
}
