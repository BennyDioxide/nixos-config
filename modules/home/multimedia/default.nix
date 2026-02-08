{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [
    ./cava.nix
    ./mpv
  ];

  programs.obs-studio.enable = !isDarwin;

  home.packages =
    with pkgs;
    [
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
    ]
    ++ lib.optionals (!isDarwin) [
      qpwgraph
      jamesdsp
      playerctl
    ];
}
