{ pkgs, ... }:

{
  home.packages = with pkgs.texlivePackages; [
    pkgs.texlab
    ctex
    beamer
    pgf
  ];
}
