{ pkgs, ... }:

let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-basic
      ctex
      beamer
      pgf
      chktex
      ;
  };
in
{
  home.packages = with pkgs; [
    tectonic
    texlab
    tex
  ];
}
