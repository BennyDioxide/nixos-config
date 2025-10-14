{ callPackage }:

let
  mkYuhao = callPackage ./base.nix;
in
{
  rime-yuhao-ming = mkYuhao {
    schemaName = "ming";
    alias = "riyue";
    hash = "sha256-GMmQSv891HJF8ra/NTSsWTMxQkpEOKNFuwblcWpOulU=";
  };
}
