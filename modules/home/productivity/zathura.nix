{ pkgs, ... }:

{
  programs.zathura.enable = !pkgs.stdenv.isDarwin;
}
