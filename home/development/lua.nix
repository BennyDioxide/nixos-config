{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs.luajitPackages; [
    fennel
  ];
}
