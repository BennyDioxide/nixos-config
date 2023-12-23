{
  description = "Benny's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix/23.10";
    hyprland.url = "github:hyprwm/Hyprland/main";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {

     nixosConfigurations = {
       "benny-nixos" = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";

         specialArgs = { inherit inputs; };
         modules = [
           ./configuration.nix
         ];
       };
     };
  };
}
