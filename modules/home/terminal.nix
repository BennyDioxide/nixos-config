{ lib, pkgs, ... }:

let
  inherit (pkgs) nushell ghostty ghostty-bin;
  inherit (pkgs.stdenv) isDarwin;
  nuExe = lib.getExe nushell;
  shell = if isDarwin then ''${lib.getExe pkgs.zsh} -c "exec ${nuExe}"'' else nuExe;
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
  programs.ghostty.package = if isDarwin then ghostty-bin else ghostty;
  programs.ghostty.settings.command = shell;
}
