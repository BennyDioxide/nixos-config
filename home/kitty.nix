{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Sakura Night"; # `kitten themes` for preview
    font.package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    font.name = "JetBrainsMono Nerd Font";
    font.size = 14;
    keybindings = { };
    environment = { };
    shellIntegration.enableZshIntegration = true;
  };
}
