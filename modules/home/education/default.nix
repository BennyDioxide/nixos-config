{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    anki
    # geogebra
  ];
}
