{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    lib.optionals (!stdenv.isDarwin) [
      anki
      # geogebra
    ];
}
