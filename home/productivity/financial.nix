{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # electrum # python3-ecdsa-0.19.1 CVE-2024-23342
  ];
}
