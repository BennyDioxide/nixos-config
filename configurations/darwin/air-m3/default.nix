{
  flake,
  config,
  pkgs,
  ...
}:

let
  inherit (flake) self;
  username = "bennyyang";
in
{
  imports = [
    {
      home-manager.users.${username} = {
        imports = [
          self.homeModules.default
        ];
      };
    }
    ./aerospace
    ./sketchybar
  ];

  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-macport;
  launchd.user.agents.emacs.environment.TERMINFO_DIRS =
    map (path: path + "/share/terminfo") config.environment.profiles
    ++ [ "/usr/share/terminfo" ];
  environment.enableAllTerminfo = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users."${username}".home = "/Users/${username}";
  system.primaryUser = username;
  system.stateVersion = 5;
}
