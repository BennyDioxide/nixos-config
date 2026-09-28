# Common modules used only in NixOS
{ flake, ... }:
{
  imports = [
    ./nix-ld.nix
    ./podman.nix
    # ./clamav.nix
    ./dolphin.nix
    # ./kmscon.nix
    ./i18n.nix
    ./fonts.nix
    ./zerotier.nix
    # ./secret.nix # FIXME
    flake.inputs.chaotic.nixosModules.default
  ];
}
