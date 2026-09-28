# Nix Flake doesn't let me use let-in syntax for some reason
{
  description = "Benny's NixOS configuration";

  nixConfig.extra-substituters = [
    "https://cache.garnix.io"
    "https://nix-community.cachix.org"
    "https://cache.nixos-cuda.org"
    "https://nixos-raspberrypi.cachix.org"

    "https://hyprland.cachix.org"
    # "https://anyrun.cachix.org"
    "https://helix.cachix.org"
    "https://niri.cachix.org"
    "https://noctalia.cachix.org"
  ];

  nixConfig.extra-trusted-public-keys = [
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
  ];

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-2605.url = "nixpkgs/nixos-26.05";
    nixpkgs-master.url = "nixpkgs/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-darwin.url = "nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
    disko.url = "disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    preservation.url = "github:nix-community/preservation";
    impermanence.url = "github:nix-community/impermanence";
    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs"; # deprecated "or"
    secrets.url = "git+ssh://git@github.com/BennyDioxide/nix-secrets.git?shallow=1";
    secrets.flake = false;
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";
    # helix.url = "github:mattwparas/helix/steel-event-system";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia/v5.0.1";
    pano-scrobbler-flake.url = "github:kawaiiDango/pano-scrobbler-flake";
    steam-presence = {
      url = "github:JustTemmie/steam-presence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waydroid-nvidia-nix.url = "github:yigexuanmu/waydroid-nvidia-nix";
    waydroid-nvidia-nix.inputs.nixpkgs.follows = "nixpkgs";
    magix.url = "github:dschrempf/magix";
  };

  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
}
