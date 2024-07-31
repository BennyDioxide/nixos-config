{ pkgs, ... }:

{
  gtk = rec {
    enable = true;
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      size = 24;
      package = pkgs.bibata-cursors;
    };
    font = {
      name = "Noto Sans CJK JP";
      size = 10;
    };
    # Prefer dark theme and Wayland text-input-v3 protocol
    gtk2.extraConfig = "gtk-im-module=\"fcitx\"";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = gtk3.extraConfig;
    gtk4.extraCss = "@import 'colors.css'"; # Required by KDE Material You Colors
  };
}
