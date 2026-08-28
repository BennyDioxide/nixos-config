{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in
{
  imports = [
    ./irc.nix
  ];

  services.syncthing.enable = isDarwin;

  home.packages =
    with pkgs;
    [
      # brave

      localsend

      telegram-desktop
      # revolt-desktop
      # element-desktop
      # slack
    ]
    ++ lib.optionals (!isDarwin) [
      # (discord.override {
      #   # withOpenASAR = true;
      #   withVencord = true;
      # })
      vesktop
    ];
}
