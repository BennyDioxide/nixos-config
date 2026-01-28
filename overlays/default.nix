# FIXME overlay kinda works, but not adopted into nixos/home-manager config
{ flake, ... }:
let
  inherit (flake) self;
in
final: prev:
let
  inherit (final.stdenv.hostPlatform) system;
in
with prev;
{
  fcitx5-rime = fcitx5-rime.override {
    rimeDataPkgs = [
      rime-data
      self.packages.${system}.rime-yuhao-ming
    ];
  };

  #  helix = prev.helix.overrideAttrs (_: {
  #    cargoBuildFeatures = [
  #      "git"
  #      "steel"
  #    ];
  #  });
}
