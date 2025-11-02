{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ardour
    # lmms
    bespokesynth-with-vst2
    drumgizmo
    calf
    dragonfly-reverb
    vital
    lsp-plugins
    x42-plugins
    x42-gmsynth
    geonkick
    zam-plugins
    yabridge
    yabridgectl

    musescore
    # (callPackage ../pkgs/pixitracker { })
    # sunvox
    # famistudio
  ];
}
