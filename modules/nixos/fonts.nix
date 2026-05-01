{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    fira-math
    jetbrains-mono
    twemoji-color-font

    nasin-nanpa
  ];
}
