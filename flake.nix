# Nix Flake doesn't let me use let-in syntax for some reason
{
  description = "Benny's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
    impermanence.url = "github:nix-community/impermanence";
    ragenix.url = "github:yaxitech/ragenix";
    secrets.url = "git+ssh://git@github.com/BennyDioxide/nix-secrets.git?shallow=1";
    secrets.flake = false;
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:mattwparas/helix/steel-event-system";
    rust-overlay.url = "github:oxalica/rust-overlay";
    autin.url = "github:atuinsh/atuin";
    # hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:danth/stylix";
    niri.url = "github:sodiboo/niri-flake";
    end-4_dots-hyprland = {
      url = "github:end-4/dots-hyprland";
      flake = false;
    };
    steam-presence = {
      url = "github:JustTemmie/steam-presence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
}
