{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    builders-use-substitutes = true;
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
    substituters = [
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
    trusted-users = [
      "root"
      (if pkgs.stdenv.isDarwin then "bennyyang" else "@wheel") # FIXME
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nix.package = pkgs.lix;
}
