{ pkgs, ... }:

{
  services.emacs.enable = !pkgs.stdenv.isDarwin;
  programs.emacs.enable = true;
}
