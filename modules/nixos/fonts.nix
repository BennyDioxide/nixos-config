{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    dejavu_fonts
    ark-pixel-font
    fira-math
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    twemoji-color-font

    nasin-nanpa
  ];
}
