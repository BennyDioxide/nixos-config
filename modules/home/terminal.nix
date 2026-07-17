{ lib, pkgs, ... }:

let
  shell = lib.getExe pkgs.nushell;
in
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
    settings = {
      inherit shell;
      cursor_trail = 10;
    };
  };

  programs.ghostty.enable = true;
  programs.ghostty.package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
  programs.ghostty.settings.command = shell;
}
