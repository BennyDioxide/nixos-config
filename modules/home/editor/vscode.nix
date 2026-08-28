{ pkgs, ... }:

{
  xdg.mimeApps.associations.added."inode/directory" = [ "code.desktop" ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        zlib
        openssl.dev
        pkg-config
      ]
    );
  };
}
