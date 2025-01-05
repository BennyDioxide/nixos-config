{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    sarasa-gothic
    # After 25.05 nerdfonts has been seperated under nerd-fonts namespace
    # To list all fonts use `builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)`
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    # (nerdfonts.override {
    #   fonts = [
    #     "FiraCode"
    #     "JetBrainsMono"
    #   ];
    # })
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
        monospace = [
          "JetBrainsMono Nerd Font"
          "Sarasa Mono J"
        ];
        emoji = [ "Twemoji" ];
      };
    };
  };
}
