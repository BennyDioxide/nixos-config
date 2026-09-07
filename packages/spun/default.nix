{
  fetchFromGitHub,
  stdenv,
  pkgconf,
  cmake,
  ninja,
  copyDesktopItems,
  makeDesktopItem,
  qt6,
  taglib,
}:

stdenv.mkDerivation {
  pname = "spun";
  version = "f950451";

  src = fetchFromGitHub {
    owner = "yappologistic";
    repo = "Spun";
    rev = "f950451f2b334ef2a9762875d07789460c2ac105";
    hash = "sha256-dENGkzGI/pkqOeM2+Z1GCgymVni2bPtQgEeeCHW/bJg=";
  };

  nativeBuildInputs = [
    pkgconf
    cmake
    ninja
    qt6.wrapQtAppsHook
    copyDesktopItems
  ];

  dontUseNinjaInstall = true;

  buildInputs = [
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtmultimedia
    qt6.qtsvg
    taglib
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "spun";
      desktopName = "Spun";
      comment = "CD-shaped music player for local files and Cider.";
      exec = "spun";
      icon = "spun";
      terminal = false;
      categories = [
        "AudioVideo"
        "Audio"
        "Player"
      ];
      mimeTypes = [
        "audio/mpeg"
        "audio/flac"
        "audio/ogg"
        "audio/x-wav"
        "audio/mp4"
      ];
      startupNotify = true;
      startupWMClass = "spun";
    })
  ];

  postInstall = ''
    install -Dm755 spun $out/bin/spun
    install -Dm644 $src/assets/spun.svg \
     $out/share/icons/hicolor/scalable/apps/spun.svg 
  '';
}
