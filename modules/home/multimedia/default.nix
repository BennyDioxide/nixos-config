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

      flake.self.packages.${system}.picard
    ]
    ++ lib.optionals (!isDarwin) [
      qpwgraph
      jamesdsp
      playerctl
      tauon
      flake.inputs.pano-scrobbler-flake.packages.${stdenv.hostPlatform.system}.default

      davinci-resolve
    ];
}
