{ lib, pkgs, isDarwin, ... }:

{
  imports = [
    ./latex.nix
    ./typst.nix
    ./zathura.nix
  ] ++ lib.optionals (!isDarwin) [
    ./music.nix
    ./graphics.nix
    ./financial.nix
  ];

  home.packages = with pkgs; [
    (if pkgs.stdenv.isDarwin then libreoffice-bin else libreoffice)
    pandoc
    logseq
    presenterm
  ];
}
