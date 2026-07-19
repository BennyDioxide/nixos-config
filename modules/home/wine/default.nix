{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # wine
    # wineWow64Packages.waylandFull
    # wineWow64Packages.stable
    # wineWow64Packages.stableFull
    wineWow64Packages.stagingFull

    # bottles
  ];

}
