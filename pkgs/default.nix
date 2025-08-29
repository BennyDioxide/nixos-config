final: prev:

with prev; {
  inherit (recurseIntoAttrs (callPackage ./rime-yuhao { })) rime-yuhao-star;
  fcitx5-rime = fcitx5-rime.override {
    rimeDataPkgs = [
      rime-data
      final.rime-yuhao-star
    ];
  };
  mpv-handler = callPackage ./mpv-handler { };
}
