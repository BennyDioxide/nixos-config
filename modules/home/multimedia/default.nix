{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [
    ./cava.nix
    ./mpv
  ];

  home.packages = with pkgs; [
    # imagemagick

    aria2
    xh
    yt-dlp
    ytarchive
    ffmpeg
    (if isDarwin then vlc-bin else vlc)
    # audacity
    spotube
    # spotify
    # spotifyd
    # spotify-tui # Removed at Mar 12, 2024, 6:14 PM GMT+8
    # davinci-resolve
    obs-studio

    qpwgraph
    jamesdsp
    playerctl
  ];
}
