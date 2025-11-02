{ pkgs, isDarwin, ... }:

{
  home.packages = with pkgs; [
    # prismlauncher
    ferium
    # modrinth-app
  ] ++ lib.optionals (!isDarwin) [
    osu-lazer-bin # network issue or smth
    mangohud
    # gamescope
  ];
}
