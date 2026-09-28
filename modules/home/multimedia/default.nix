{
  flake,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin system;
in
{
  imports = [
    ./cava.nix
    ./mpv
  ];

  programs.obs-studio.enable = !isDarwin;

  programs.yt-dlp.enable = true;
  programs.yt-dlp.package = pkgs.yt-dlp_git;

  home.packages =
    let
      inherit (flake.self.packages.${system}) picard spun;
    in
    with pkgs;
    [
      # imagemagick

      aria2
      xh
      ytarchive
      ffmpeg
      (if isDarwin then vlc-bin else vlc)
      # audacity
      spotube
      # spotify
      # spotifyd
      # spotify-tui # Removed at Mar 12, 2024, 6:14 PM GMT+8

      picard
    ]
    ++ lib.optionals (!isDarwin) [
      qpwgraph
      jamesdsp
      playerctl
      tauon
      flake.inputs.pano-scrobbler-flake.packages.${system}.default
      spun
    ];
}
