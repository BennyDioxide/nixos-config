{ config, pkgs, ... }:

{
  xdg.portal =
    let
      portals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];
      kde = [ "kde" ];
    in
    {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = portals;
      configPackages = portals;
      config = {
        common = {
          default = [ "kde" "gtk" ];
        };
        hyprland = {
          default = [ "hyprland" "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = kde;
          "org.freedesktop.impl.portal.AppChooser" = kde;
          "org.freedesktop.impl.portal.ScreenCast" = kde;
        };
      };
    };
}
