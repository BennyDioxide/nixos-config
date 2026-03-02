{ pkgs, ... }:
let
  combinedSdk =
    with pkgs.dotnetCorePackages;
    combinePackages [
      dotnet_8.sdk
      dotnet_9.sdk
      dotnet_10.sdk
    ];
in
{
  home.sessionVariables = {
    DOTNET_ROOT = "${combinedSdk}/share/dotnet";
  };
  home.packages = [ combinedSdk ];
}
