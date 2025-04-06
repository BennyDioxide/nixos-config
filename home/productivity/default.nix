{ pkgs, ... }:

{
  imports = [
    ./latex.nix
    ./typst.nix
  ];

  home.packages = with pkgs; [
    (if pkgs.stdenv.isDarwin then libreoffice-bin else libreofice)
    pandoc
  ];
}
