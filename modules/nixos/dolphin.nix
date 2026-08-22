{ pkgs, ... }:
{
  # Fix Dolphin file associations on non-Plasma desktop environments
  # https://github.com/NixOS/nixpkgs/issues/409986
  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu"; # Enable Hyprland in sddm

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qtimageformats
    kdePackages.kimageformats

    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras

    # Previews
    kdePackages.ffmpegthumbs
    kdePackages.kdegraphics-thumbnailers
    icoutils
    libappimage
    taglib
  ];

  services.udisks2.enable = true;
}
