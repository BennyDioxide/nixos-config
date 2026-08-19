{ flake, pkgs, ... }:
let
  inherit (flake.inputs) waydroid-nvidia-nix;
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [ waydroid-nvidia-nix.nixosModules.waydroid-nvidia ];

  # waydroid-nvidia-nix lacks lots of config
  virtualisation.lxc.enable = true;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  services.waydroid-nvidia.enable = true;
  services.waydroid-nvidia.package = waydroid-nvidia-nix.packages.${system}.waydroid-nvidia-full;
  services.waydroid-nvidia.refreshRate = 75;
}
