{ pkgs, ... }:

{
  imports = [
    ./latex.nix
    ./typst.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    (if pkgs.stdenv.isDarwin then libreoffice-bin else libreoffice)
    pandoc
    presenterm
  ];
}
