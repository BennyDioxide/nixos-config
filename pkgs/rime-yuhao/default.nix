{ callPackage }:

let
  mkYuhao = callPackage ./base.nix;
in
{
  rime-yuhao-ming = mkYuhao {
    schemaName = "ming";
    alias = "riyue";
    hash = "sha256-Eb4ZxPVZesZz/LiKX8PelUm9lYR6kMUYY11bo7VO1kU=";
  };
}
