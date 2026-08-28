{ pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  prismlauncher' = pkgs.prismlauncher.override {
    additionalPrograms = [ pkgs.zenity ];
    jdks = [
      pkgs.graalvmPackages.graalvm-ce
      pkgs.temurin-bin-25
      pkgs.zulu25
      pkgs.zulu8
    ];
  };
in
{
  home.packages =
    with pkgs;
    [
      prismlauncher'
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
