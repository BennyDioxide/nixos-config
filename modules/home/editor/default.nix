{
  flake,
  lib,
  pkgs,
  ...
}:
let
  inherit (flake) self;
  inherit (pkgs.stdenv) isDarwin hostPlatform;
in
{
  imports = [
    ./emacs.nix
    ./helix.nix
  ];

  programs.rime-ls = {
    enable = !isDarwin;
    rimePackage = pkgs.fcitx5-rime.override {
      rimeDataPkgs = [
        pkgs.rime-data
        self.packages.${hostPlatform.system}.rime-yuhao-ming
      ];
    };
    settings = {
      max_tokens = 4;
      always_incomplete = true;
    };
  };

  home.packages =
    with pkgs;
    lib.optionals (!isDarwin) [
      jetbrains-toolbox
      # jetbrains.rust-rover
      jetbrains.rider
      # jetbrains.clion
      # jetbrains.pycharm-professional
      # jetbrains.pycharm-community
      jetbrains.idea
      # android-studio-full
      # androidStudioPackages.beta
      unityhub

      # Broken on macOS
      zed-editor
    ];
}
