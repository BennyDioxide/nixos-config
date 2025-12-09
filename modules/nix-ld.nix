{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib
      atk
      cairo
      cups
      curl
      dbus
      fontconfig
      freetype
      fuse2
      fuse3
      gdk-pixbuf
      glib
      gtk2
      gtk3
      harfbuzz
      icu
      krb5
      libGL
      libappindicator-gtk3
      libdrm
      libnotify
      libpulseaudio
      librsvg
      libsoup_3
      libunwind
      libxkbcommon
      mesa
      openssl
      pango
      pipewire
      stdenv.cc.cc
      systemd
      # webkitgtk_4_0
      webkitgtk_4_1
      vulkan-loader
      vips
      xdotool
      xorg.libX11
      xorg.libXcursor
      xorg.libxcb
      xorg.libXi
      zlib
    ];
  };
}
