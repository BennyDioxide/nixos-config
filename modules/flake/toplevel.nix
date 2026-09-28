# Top-level flake glue to get our configuration working
{
  self,
  inputs,
  config,
  lib,
  ...
}:
let
  specialArgs = {
    unstablePkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
    flake = { inherit self inputs config; };
  };

  nixosModules = {
    # Linux home-manager module
    home-manager = {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.sharedModules = [ homeModules.common ];
        }
      ];
    };

    # Common and useful setting across all platforms
    common = { lib, ... }: {
      nix = {
        settings = {
          # Use all CPU cores
          max-jobs = lib.mkDefault "auto";
          # Duh
          experimental-features = lib.mkDefault "nix-command flakes";
        };
      };
    };
  };

  homeModules.common = { config, pkgs, ... }: {
    # Sensible default for `home.homeDirectory`
    home.homeDirectory = lib.mkDefault "/${
      if pkgs.stdenv.hostPlatform.isDarwin then "Users" else "home"
    }/${config.home.username}";

    # For macOS, $PATH must contain these.
    home.sessionPath = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [
      "/etc/profiles/per-user/$USER/bin" # To access home-manager binaries
      "/nix/var/nix/profiles/system/sw/bin" # To access nix-darwin binaries
      "/usr/local/bin" # Some macOS GUI programs install here
    ];
  };
in
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];

  perSystem =
    { self', pkgs, ... }:
    {
      # For 'nix fmt'
      formatter = pkgs.nixpkgs-fmt;

      # Enables 'nix run' to activate.
      packages.default = self'.packages.activate;
    };

  flake.nixosConfigurations.cryogenic-pi = lib.mkForce (
    inputs.nixos-raspberrypi.lib.nixosSystem {
      inherit specialArgs;

      modules = [
        ../../configurations/nixos/cryogenic-pi
        nixosModules.common
        nixosModules.home-manager
      ];
    }
  );
}
