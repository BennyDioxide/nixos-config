{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ardour
    # lmms
    reaper
    # bespokesynth-with-vst2
    drumgizmo
    calf
    dragonfly-reverb
    vital
    surge-xt
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
