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
  home.packages =
    with pkgs;
    [
      revolt-desktop
    ]
    ++ lib.optionals (!isDarwin) [
      (discord.override { withOpenASAR = true; withVencord = true; })
    ];
}
