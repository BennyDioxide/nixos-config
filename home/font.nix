{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    sarasa-gothic
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    jetbrains-mono
    fira-math
    twemoji-color-font

    nasin-nanpa
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Noto Sans CJK JP"
          "nasin-nanpa"
        ];
        serif = [ "Noto Serif CJK JP" ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Sarasa Mono J"
        ];
        emoji = [ "Twemoji" ];
      };
    };
  };
}
