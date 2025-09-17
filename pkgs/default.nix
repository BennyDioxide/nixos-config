final: prev:

with prev; {
  inherit (recurseIntoAttrs (callPackage ./rime-yuhao { })) rime-yuhao-ming;
  fcitx5-rime = fcitx5-rime.override {
    rimeDataPkgs = [
      rime-data
      final.rime-yuhao-ming
    ];
  };
  mpv-handler = callPackage ./mpv-handler { };
}
