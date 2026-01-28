{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # wine
    # wineWowPackages.waylandFull
    # wineWowPackages.stable
    # wineWowPackages.stableFull
    wineWowPackages.stagingFull

    bottles
  ];

}
