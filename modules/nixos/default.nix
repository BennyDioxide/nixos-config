# Common modules used only in NixOS

{
  imports = [
    ./nix-ld.nix
    ./podman.nix
    # ./clamav.nix
    ./dolphin.nix
    ./kmscon.nix
    ./i18n.nix
    ./fonts.nix
    ./zerotier.nix
    # ./secret.nix # FIXME
  ];
}
