{ flake, pkgs, ... }:
let
  inherit (flake.inputs) waydroid-nvidia-nix;
  inherit (pkgs.stdenv.hostPlatform) system;

  waydroid-nvidia-pkgs = waydroid-nvidia-nix.packages.${system};

  virglrenderer-nvidia = waydroid-nvidia-pkgs.virglrenderer-nvidia.overrideAttrs {
    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "virgl";
      repo = "virglrenderer";
      rev = "dc35e4db03144f81637c5ad061f61d3334b078fe";
      hash = "sha256-dhu1YNd9cukbUCBXjG3NL95u+lo8br1jap4+/kTAqEY=";
    };

  };

  waydroid-nvidia = waydroid-nvidia-pkgs.waydroid-nvidia.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "waydroid";
      repo = "waydroid";
      rev = "a33a5c0b31d89d6ce687381104b30aff4dd2d330";
      hash = "sha256-V8TTnfnsujDnW9Q2SZN/+2jPxxtWLbiSTydK8Jv4QS0=";
    };
  };

  waydroid-nvidia-full = waydroid-nvidia-pkgs.waydroid-nvidia-full.override {
    inherit virglrenderer-nvidia waydroid-nvidia;
  };
in
{
  imports = [ waydroid-nvidia-nix.nixosModules.waydroid-nvidia ];

  # waydroid-nvidia-nix lacks lots of config
  virtualisation.lxc.enable = true;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  services.waydroid-nvidia.enable = true;
  services.waydroid-nvidia.package = waydroid-nvidia-full;
  services.waydroid-nvidia.refreshRate = 75;
}
