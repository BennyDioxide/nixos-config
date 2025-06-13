{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    # "auto_install_extensions"
    extensions = [
      "nix"
      "haskell"
      "clojure"
      "toml"
      "html"
      "latex"
      "zig"
      "catppuccin"
    ];
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
      languages = {
        Nix = {
          formatter.external.command = lib.getExe pkgs.nixfmt-rfc-style;
        };
        Rust = {
          language_servers = [
            "rust-analyzer"
            "tailwindcss-language-server"
          ];
        };
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
          nix = {
            binary = lib.getExe pkgs.nix;
            maxMemoryMB = 2048;
            flake.autoArchive = true;
          };
        };
        tailwindcss-language-server.settings = {
          includeLanguages = {
            rust = "html";
          };
          experimental.classRegex = [
            # Dioxus
            "class: \"(.*)\""
            # Tailwind Fuse
            "#[tw\\\\([^\\]]*class\\s*=\\s*\"([^\"]*)\"\\)]"
            "\"([^\"]*)\""
          ];
        };
      };
    };
  };
}
