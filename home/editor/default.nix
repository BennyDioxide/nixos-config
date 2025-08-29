{ lib, isDarwin, ... }:

{
  imports = [
    ./helix.nix
    ./zed.nix
  ]
  ++ lib.optionals (!isDarwin) [
    ./vscode.nix
  ];

  programs.rime-ls = {
    enable = true;
    settings = {
      max_tokens = 4;
      always_incomplete = true;
    };
  };
}
