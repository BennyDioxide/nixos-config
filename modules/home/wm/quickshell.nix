{ pkgs, ... }:
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

  programs.quickshell.enable = true;
}
