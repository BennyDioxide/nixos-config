{ pkgs, ... }:

{
  xdg.mimeApps.associations.added."inode/directory" = [
    "emacs.desktop"
    "emacsclient.desktop"
  ];

  services.emacs.enable = !pkgs.stdenv.hostPlatform.isDarwin;
  programs.emacs.enable = true;
}
