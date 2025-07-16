{ callPackage }:

let
  mkYuhao = callPackage ./base.nix;
in
{
  rime-yuhao-star = mkYuhao {
    schemaName = "star";
    alias = "xingchen";
    hash = "sha256-Eb4ZxPVZesZz/LiKX8PelUm9lYR6kMUYY11bo7VO1kU=";
  };
}
