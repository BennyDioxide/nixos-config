{ lib, ... }:

{
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  services.aerospace =
    let
      keymap = import ./keymap.nix;
    in
    {
      enable = true;
      settings = {
        default-root-container-layout = "tiles";
        enable-normalization-opposite-orientation-for-nested-containers = true;
        key-mapping.key-notation-to-key-code = keymap.colemak-dh;
        mode.main.binding =
          {
            alt-slash = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";

            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            alt-minus = "resize smart -50";
            alt-equal = "resize smart +50";

            alt-tab = "workspace-back-and-forth";
          }
          // builtins.listToAttrs (
            map (n: lib.nameValuePair "alt-${toString n}" "workspace ${toString n}") (lib.range 1 9)
          )
          // builtins.listToAttrs (
            map (c: lib.nameValuePair "alt-${lib.toLower c}" "workspace ${c}") (
              lib.stringToCharacters "ABCDEFGIMNOPQRSTUVWXYZ"
            )
          )
          // builtins.listToAttrs (
            map (n: lib.nameValuePair "alt-shift-${toString n}" "move-node-to-workspace ${toString n}") (
              lib.range 1 9
            )
          )
          // builtins.listToAttrs (
            map (c: lib.nameValuePair "alt-shift-${lib.toLower c}" "move-node-to-workspace ${c}") (
              lib.stringToCharacters "ABCDEFGIMNOPQRSTUVWXYZ"
            )
          );
      };
    };
}
