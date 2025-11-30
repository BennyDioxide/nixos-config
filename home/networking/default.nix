{
  lib,
  pkgs,
  isDarwin,
  ...
}:
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
       vesktop
    ];
}
