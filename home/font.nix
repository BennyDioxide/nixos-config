{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
    jetbrains-mono
    fira-math
    twemoji-color-font
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK JP" ];
        serif = [ "Noto Serif CJK JP" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono CJK JP" ];
        emoji = [ "Twemoji" ];
      };
    };
  };
}
