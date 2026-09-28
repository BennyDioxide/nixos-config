{ unstablePkgs, ... }:
let
  overlay = final: prev: {
    inherit (unstablePkgs)
      nushell
      helix
      zed-editor
      ghostty
      kitty
      ;
  };
in
{
  nixpkgs.overlays = [ overlay ];
}
