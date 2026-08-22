{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
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

      revolt-desktop
      telegram-desktop
      # element-desktop
      slack
    ]
    ++ lib.optionals (!isDarwin) [
      (discord.override {
        # withOpenASAR = true;
        withVencord = true;
      })
      vesktop
    ];
}
