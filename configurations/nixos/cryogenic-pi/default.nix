{
  flake,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (flake) inputs self;
  inherit (inputs) disko nixos-raspberrypi;
  rpiModules = nixos-raspberrypi.nixosModules;
  username = "benny";
in
{
  imports = [
    rpiModules.raspberry-pi-4.base
    rpiModules.raspberry-pi-4.bluetooth
    disko.nixosModules.disko
    ./disk-config.nix # WARNING DESTRUCTIVE operation
    self.nixosModules.default
    self.nixosModules.common
    ./hardware-configuration.nix
    ./home.nix
    ./overlay.nix
    ./networking.nix
    # ./overlay.nix
    ./preservation.nix
  ];

  nix.package = lib.mkForce pkgs.nix;

  # boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
  boot.tmp.useTmpfs = true;

  time.timeZone = "Asia/Taipei";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "gpio"
      "input"
      config.hardware.i2c.group # ddcutil/brightness control
    ];
    shell = pkgs.nushell;
    initialHashedPassword = "$6$/szlskJfM4YH8E/I$SbAytLxeFq.lK2yKcLw0J0CkhcygGi/uwpj3EP6xhD4KUv3X7c0lB5nbbPkNN8cENZEQ3JaPcbwB/F0uVmeWM.";
  };
  users.users.root.initialHashedPassword = ""; # FIXME
  environment.systemPackages = with pkgs; [
    helix
    btop
    yazi
    bat
    ripgrep
    fd
    nh
    ddcutil
    nixos-firewall-tool
  ];

  services.getty.autologinUser = username;

  services.displayManager = {
    ly.enable = true;
    defaultSession = "hyprland-uwsm";
    autoLogin = {
      enable = true;
      user = username;
    };
  };
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  security.polkit.enable = true;
  services.openssh.enable = true;

  hardware.graphics.enable = true;
  # For ddcutil/brightness control
  hardware.i2c.enable = true;

  system.stateVersion = "26.11";
}
