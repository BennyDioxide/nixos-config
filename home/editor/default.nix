{ lib, pkgs, isDarwin, ... }:

{
  imports = [
    ./emacs.nix
    ./helix.nix
    ./zed.nix
  ]
  ++ lib.optionals (!isDarwin) [
    ./vscode.nix
  ];

  programs.rime-ls = {
    enable = !isDarwin;
    settings = {
      max_tokens = 4;
      always_incomplete = true;
    };
  };

  home.packages = with pkgs; [
    # jetbrains.rust-rover
    jetbrains.rider
    # jetbrains.clion
    # jetbrains.pycharm-professional
    # jetbrains.pycharm-community
    # jetbrains.idea-professional
    # jetbrains.idea-community
    # android-studio-full
    # androidStudioPackages.beta
  ] ++ lib.optionals (!isDarwin) [
    jetbrains-toolbox
    unityhub

    # Broken on macOS
    zed-editor
  ];
}
