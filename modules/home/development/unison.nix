{ pkgs, ... }:
{
  home.packages = [ pkgs.unison-ucm ];

  programs.helix.languages = {
    language-server.ucm = {
      command = "nc";
      args = [
        "localhost"
        "5757"
      ];
    };
    languages = [
      {
        name = "unison";
        language-servers = [ "ucm" ];
      }
    ];
  };
}
