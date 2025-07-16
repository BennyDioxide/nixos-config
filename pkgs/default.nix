pkgs:

with pkgs; {
  inherit (recurseIntoAttrs (callPackage ./rime-yuhao { })) rime-yuhao-star;
  mpv-handler = callPackage ./mpv-handler { };
}
