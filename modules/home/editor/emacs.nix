{ pkgs, ... }:

{
  xdg.mimeApps.associations.added."inode/directory" = [
    "emacs.desktop"
    "emacsclient.desktop"
  ];

  services.emacs.enable = !pkgs.stdenv.isDarwin;
  programs.emacs.enable = true;
}
