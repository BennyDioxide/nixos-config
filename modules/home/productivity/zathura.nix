{ pkgs, ... }:

{
  programs.zathura.enable = !pkgs.stdenv.hostPlatform.isDarwin;
}
