{ lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "fleet_dark";
      editor = {
        true-color = true;
        cursorline = true;
        line-number = "relative";
        rulers = [ 80 ];
        shell = [
          "nu"
          "-c"
        ];
        bufferline = "always";

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "block";
        };
      };

      keys.normal = {
        n = "move_visual_line_down";
        e = "move_visual_line_up";
        i = "move_char_right";
        s = "insert_mode";
        G = "select_regex";
        l = "extend_line_below";
        space.x.s = ":write";
        space.x.c = ":quit";
        "[".l = "goto_line_start";
        "]".l = "goto_line_end";
        minus.f = "find_prev_char";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
      {
        name = "markdown";
        scope = "source.markdown";
        file-types = [
          "md"
          "markdown"
        ];
        language-servers = [ "rime-ls" ];
      }
    ];
    languages.language-server = {
      texlab = {
        build.executable = "tectonic";
        build.args = [
          "-X"
          "compile"
          "%f"
          "--synctex"
          "--keep-logs"
          "--keep-intermediates"
          "--outdir=build"
          "-Zshell-excape"
        ];
        build.onSave = true;
        build.auxDirectory = "build";
        build.logDirectory = "build";
        build.pdfDirectory = "build";
        build.forwardSearchAfter = true;

        chktex.onOpenAndSave = true;
        chktex.onEdit = true;

        forwardSearch.executable = "zathura";
        args = [
          "--synctex-forward"
          "%l:%c:%f"
          "%p"
        ];
      };
    };
  };
}
