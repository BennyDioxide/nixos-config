{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home.packages =
    with pkgs;
    [
      prismlauncher
      ferium
      # modrinth-app
    ]
    ++ lib.optionals (!isDarwin) [
      osu-lazer-bin # network issue or smth
      mangohud
      gamescope
      (heroic.override {
        extraPkgs = pkgs: [ pkgs.gamescope ];
      })
    ];
}
