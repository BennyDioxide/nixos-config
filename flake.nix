{
  description = "Benny's NixOS configuration";

  nixConfig = {
    builders-use-substitutes = true;
    trusted-substituters = [
      "https://hyprland.cachix.org"
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url =
      "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "helix/24.03";
    rust-overlay.url = "github:oxalica/rust-overlay";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    end-4_dots-hyprland = {
      url = "github:BennyDioxide/dots-hyprland";
      flake = false;
    };
  };

  outputs =
    inputs@{ nixpkgs
    , nixpkgs-master
    , home-manager
    , rust-overlay
    , ...
      impermanence,
    }:
    let
      pkgs-configuration = {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (final: prev: import ./pkgs prev) ];
      };
      system = "x86_64-linux";
      extraSpecialArgs = {
        inherit inputs;
        pkgs-master = import nixpkgs-master pkgs-configuration;
      };
    in
    {
      nixosConfigurations."benny-nixos" = nixpkgs.lib.nixosSystem rec {
        inherit system;

        specialArgs = extraSpecialArgs;
        modules = [
          impermanence.nixosModules.impermanence
          ./hardware-configuration.nix
          ./configuration.nix

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
