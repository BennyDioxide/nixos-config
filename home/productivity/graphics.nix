{ lib, pkgs, isDarwin, ... }:

{
  home.packages = with pkgs; lib.optionals (!isDarwin) [
    blender
    blockbench
    inkscape
    krita
  ];
}
