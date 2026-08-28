{
  flake,
  config,
  pkgs,
  ...
}:

let
  inherit (flake) self;
  inherit (flake.inputs) chaotic;
  username = "bennyyang";
in
{
  imports = [
    self.darwinModules.default
    chaotic.nixosModules.nyx-cache
    chaotic.nixosModules.nyx-overlay
    chaotic.nixosModules.nyx-registry
    ./aerospace
    ./sketchybar
  ];

  # home-manager.useGlobalPkgs = lib.mkForce false; # For chaotic-nyx
  home-manager.users.${username} = {
    imports = [
      self.homeModules.default
      self.homeModules.darwin-only
    ];

  };

  services.emacs.enable = false;
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
