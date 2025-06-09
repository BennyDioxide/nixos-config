{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    # "auto_install_extensions"
    extensions = ["nix" "haskell" "clojure" "toml" "html" "latex" "zig" "catppuccin"];
    userSettings = {
      features.edit_prediction_provider = "zed";
      ui_font_size = 16;
      buffer_font_size = 16;
      vim_mode = true;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Catppuccin Mocha";
      };
      terminal = {
        font_family = "JetBrainsMono Nerd Font";
      };
      lsp = {
        rust-analyzer = {
          binary.path = lib.getExe pkgs.rust-analyzer;
        };
        hls = {
          # initialization_options.haskell.formattingProvider = lib.getExe pkgs.ormolu;
          initialization_options.haskell.formattingProvider = "ormolu";
        };
        nil = {
          formatting.command = lib.getExe pkgs.nixfmt-rfc-style;
          nix = {
            binary = lib.getExe pkgs.nix;
            maxMemoryMB = 2048;
            flake.autoArchive = true;
          };
        };
      };
    };
  };
}
