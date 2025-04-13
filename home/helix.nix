{ pkgs, ... }:

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

      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
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
