{ pkgs, ... }:

let
  libera = {
    address = "irc.ea.libera.chat";
    nickname = "BennyDioxide";
    password-cmd = [
      "${pkgs.gopass}/bin/gopass"
      "show"
      "irc/main"
    ];
  };
in
{
  programs.senpai = {
    enable = true;
    config = libera;
  };
  programs.halloy = {
    enable = true;
    settings.servers.liberachat = {
      inherit (libera) nickname;
      server = libera.address;
      channels = [
        "##swtw"
        "#halloy"
        "#senpai"
      ];
      nick_password_command = builtins.concatStringsSep " " libera.password-cmd;
    };
  };
}
