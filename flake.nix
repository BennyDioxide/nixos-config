{
  description = "Benny's NixOS configuration";

  inputs = {
    nixpkgs.url =
      "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "helix/24.03";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
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
