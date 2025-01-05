# Nix Flake doesn't let me use let-in syntax for some reason
rec {
  description = "Benny's NixOS configuration";

  nixConfig = {
    builders-use-substitutes = true;
    trusted-substituters = [
      # cache mirror in China
      # status: https://mirror.sjtu.edu.cn/
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

      "https://cache.garnix.io"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"

      "https://hyprland.cachix.org"
      # "https://anyrun.cachix.org"
      "https://helix.cachix.org"
      "https://niri.cachix.org"
    ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "helix/24.03";
    rust-overlay.url = "github:oxalica/rust-overlay";
    autin.url = "github:atuinsh/atuin";
    # hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
    niri.url = "github:sodiboo/niri-flake";
    end-4_dots-hyprland = {
      url = "github:BennyDioxide/dots-hyprland";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-master,
      impermanence,
      home-manager,
      musnix,
      rust-overlay,
      autin,
      helix,
      niri,
      stylix,
      ...
    }:
    let
      pkgs-configuration = {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "electron-27.3.11" # EOL
          "dotnet-sdk-7.0.410" # EOL
          "dotnet-sdk-wrapped-7.0.410" # EOL
          "dotnet-runtime-7.0.20" # EOL
          "dotnet-runtime-wrapped-7.0.20" # EOL
        ];
        # config.permittedInsecurePackages = [ "electron-28.3.3" ];
        overlays = [
          rust-overlay.overlays.default
          # autin.overlays.default
          helix.overlays.default
          (final: prev: import ./pkgs prev)
        ];
      };
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        pkgs-master = import nixpkgs-master pkgs-configuration;
      };
    in
    {
      nixosConfigurations."benny-nixos" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;

        modules = [
          impermanence.nixosModules.impermanence
          ./hardware-configuration.nix
          ./configuration.nix
          ./modules
          musnix.nixosModules.musnix
          niri.nixosModules.niri
          # stylix.nixosModules.stylix
          (
            { pkgs, ... }:

            {
              nix.settings = {
                inherit (nixConfig) builders-use-substitutes trusted-public-keys;
                substituters = nixConfig.trusted-substituters;
                trusted-users = [ "benny" ];
              };
              nixpkgs = pkgs-configuration;
            }
          )
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.benny = import ./home;
            };
          }
        ];
      };
      #   homeConfigurations.benny = home-manager.lib.homeManagerConfiguration {
      #     inherit extraSpecialArgs;
      #     modules = [
      #       ./home
      #       (
      #         { pkgs, ... }:
      #         {
      #           nixpkgs.overlays = [
      #             rust-overlay.overlays.default
      #             # autin.overlays.default
      #             helix.overlays.default
      #           ];
      #           home.packages = [ pkgs.rust-bin.stable.latest.default ];
      #         }
      #       )
      #     ];
      #     pkgs = import nixpkgs pkgs-configuration;
      #   };
    };
}
