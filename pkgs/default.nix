final: prev:

with prev; {
  inherit (recurseIntoAttrs (callPackage ./rime-yuhao { })) rime-yuhao-ming;
  fcitx5-rime = fcitx5-rime.override {
    rimeDataPkgs = [
      rime-data
      final.rime-yuhao-ming
    ];
  };

  helix = prev.helix.overrideAttrs (_: {
    cargoBuildFeatures = [
      "git"
      "steel"
    ];
  });
}
