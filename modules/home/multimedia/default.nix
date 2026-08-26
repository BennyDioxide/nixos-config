{
  flake,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
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
      yt-dlp_git
      ytarchive
      ffmpeg
      (if isDarwin then vlc-bin else vlc)
      # audacity
      spotube
      # spotify
      # spotifyd
      # spotify-tui # Removed at Mar 12, 2024, 6:14 PM GMT+8
      davinci-resolve

      tauon
      flake.inputs.pano-scrobbler-flake.packages.${stdenv.hostPlatform.system}.default
      picard
    ]
    ++ lib.optionals (!isDarwin) [
      qpwgraph
      jamesdsp
      playerctl
    ];
}
