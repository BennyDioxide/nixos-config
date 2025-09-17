# Nix Flake doesn't let me use let-in syntax for some reason
rec {
  description = "Benny's NixOS configuration";

  nixConfig = {
    builders-use-substitutes = true;
    trusted-substituters = [
      # cache mirror in China
      # status: https://mirror.sjtu.edu.cn/
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

      "https://cache.garnix.io"
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
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-master,
      nix-darwin,
      impermanence,
      home-manager,
      musnix,
      rust-overlay,
      autin,
      helix,
      hyprland,
      niri,
      stylix,
      ...
    }:
    let
      pkgs-configuration = isDarwin: {
        hostPlatform = if isDarwin then "aarch64-darwin" else "x86_64-linux";
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
          # hyprland.overlays.default
          niri.overlays.niri
          (import ./pkgs)
        ];
      };
      specialArgs = isDarwin: {
        inherit inputs isDarwin;
        pkgs-master = import nixpkgs-master (pkgs-configuration isDarwin);
      };
      nixSettings =
        user: isDarwin:
        { pkgs, ... }:

        {
          nix.settings = {
            inherit (nixConfig) builders-use-substitutes trusted-public-keys;
            substituters = nixConfig.trusted-substituters;
            trusted-users = [ user ];

            experimental-features = [
              "nix-command"
              "flakes"
            ];
            # auto-optimise-store = true; # known to corrupt the store
          };
          nix.package = pkgs.lix;
          # optimise.automatic = true;
          nixpkgs = pkgs-configuration isDarwin;
        };
      home = user: isDarwin: {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = specialArgs isDarwin;
        users."${user}" = import ./home;
      };

    in
    {
      nixosConfigurations."benny-nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs false;

        system = "x86_64-linux";
        modules = [
          impermanence.nixosModules.impermanence
          ./hosts/benny-nixos
          ./modules
          musnix.nixosModules.musnix
          niri.nixosModules.niri
          # stylix.nixosModules.stylix
          (nixSettings "benny" false)
          home-manager.nixosModules.home-manager
          {
            home-manager = home "benny" false;
          }
        ];
      };
      darwinConfigurations."yangshitings-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/air-m3
          (nixSettings "bennyyang" true)
          home-manager.darwinModules.home-manager
          {
            home-manager = home "bennyyang" true;
          }
        ];
      };
    };
}
