{ pkgs, lib, ... }:

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
        shell = [ "nu" "-c" ];
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
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
    }];
  };
}
