{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.zsh = {
    inherit (config.home) sessionVariables;

    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    initContent = ''
      autoload -U select-word-style
      select-word-style bash

      setopt correct extendedglob

      function mkcd() {
        mkdir $1 && cd $1
      }

      # bindkey "^[[1;5C" forward-word # Ctrl+Right
      # bindkey "^[[31;5D" backward-word # Ctrl+Left
      # bindkey "^H" backward-kill-word # Ctrl+Backspace
      # bindkey "^[[3~;5~" kill-word # Ctrl+Delete
      ${if isDarwin then "eval \"$(/opt/homebrew/bin/brew shellenv)\"" else ""}
    '';
    shellAliases = {
      ls = "eza --icons";
      la = "ls -a";
      ll = "ls -al";
      mpv-pixel = "mpv --vo-set=tct --quiet";
      spf = lib.getExe pkgs.superfile;
    };
    plugins = with pkgs; [
      {
        name = "fast-syntax-highlighting";
        file = "F-Sy-H.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "3bd4aa2"; # Merge branch 'z-shell:main' into main
          sha256 = "sha256-RKybDFJ7P0AySVebHGilm10pf5VYu4CZGib+TgnpTAE=";
        };
      }
      # Let you use zsh in nix-shell
      {
        name = "zsh-nix-shell";
        src = fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
        };
      }
    ];
  };
}
