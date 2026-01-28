{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    blockbench
    inkscape
    krita
  ];
}
