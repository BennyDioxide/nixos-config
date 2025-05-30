{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha"; # `kitten themes` for preview
    # Kitty has nerd-fonts builtin
    font.package = pkgs.jetbrains-mono;
    font.name = "JetBrains Mono";
    font.size = 14;
    keybindings = { };
    environment = { };
    shellIntegration.enableZshIntegration = true;
  };
}
