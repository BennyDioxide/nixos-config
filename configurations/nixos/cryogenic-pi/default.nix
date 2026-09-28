{
  flake,
  config,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) disko nixos-raspberrypi;
  rpiModules = nixos-raspberrypi.nixosModules;
  username = "benny";
in
{
  imports = [
    rpiModules.raspberry-pi-4.base
    rpiModules.raspberry-pi-4.bluetooth
    rpiModules.trusted-nix-caches
    nixos-raspberrypi.lib.int.default-nixos-raspberrypi-config # I'm using nixos-unified lol
    disko.nixosModules.disko
    ./disk-config.nix # WARNING DESTRUCTIVE operation
    flake.self.nixosModules.default
    flake.self.nixosModules.common
    ./hardware-configuration.nix
    ./networking.nix
    # ./overlay.nix
    ./preservation.nix
  ];

  boot.tmp.useTmpfs = true;

  time.timeZone = "Asia/Taipei";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      config.hardware.i2c.group # ddcutil/brightness control
    ];
    shell = pkgs.nushell;
    initialHashedPassword = ""; # FIXME
  };
  users.users.root.initialHashedPassword = ""; # FIXME

  services.getty.autologinUser = username;
  security.polkit.enable = true;
  services.openssh.enable = true;

  hardware.graphics.enable = true;
  # For ddcutil/brightness control
  hardware.i2c.enable = true;

  system.stateVersion = "26.11";
}
