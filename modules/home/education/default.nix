{
  lib,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    lib.optionals (!stdenv.hostPlatform.isDarwin) [
      anki
      # geogebra
    ];
}
