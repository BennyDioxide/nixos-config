{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
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
