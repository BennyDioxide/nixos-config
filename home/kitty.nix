{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha"; # `kitten themes` for preview
    font.package = pkgs.nerd-fonts.jetbrains-mono;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 14;
    keybindings = { };
    environment = { };
    shellIntegration.enableZshIntegration = true;
  };
}
