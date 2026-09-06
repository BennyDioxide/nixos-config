{
  lib,
  stdenv,
  python3Packages,
  fetchFromGitHub,

  cacert,
  gettext,
  qt6,

  gst_all_1,

  writableTmpDirAsHomeHook,
  nix-update-script,
}:

let
  pythonPackages = python3Packages;
in
pythonPackages.buildPythonApplication (finalAttrs: {
  pname = "picard";
  version = "3.0.0rc1";
  pyproject = true;
  strictDeps = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "metabrainz";
    repo = "picard";
    tag = "release-${finalAttrs.version}";
    hash = "sha256-iNr7+TWuwjo7mx0fgYvRcfRAJ/qBqaC0cT0cx6qku8g=";
  };

  nativeBuildInputs = [
    gettext
    qt6.wrapQtAppsHook
    pythonPackages.setuptools
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtmultimedia
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
  ]
  ++ lib.optionals (lib.meta.availableOn stdenv.hostPlatform qt6.qtwayland) [
    qt6.qtwayland
  ];

  pythonRelaxDeps = lib.optionals stdenv.hostPlatform.isDarwin [
    # Should be resolved in the next version
    "pyobjc-core"
    "pyobjc-framework-Cocoa"
    "pyobjc-framework-MediaPlayer"
  ];

  dependencies =
    with pythonPackages;
    [
      discid
      markdown
      mutagen
      pyjwt
      pyqt6
      pyyaml
      charset-normalizer
      pygit2
      tomlkit
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      pyobjc-core
      pyobjc-framework-Cocoa
      pyobjc-framework-MediaPlayer
    ];

  disabledTestPaths = [
    "test/test_util_filenaming.py::ShortFilenameTest::test_bmp_unicode_on_nix" # - AssertionError: 'ßßßß[191 chars]ßßßßß/ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß...
    "test/test_util_filenaming.py::ShortFilenameTest::test_nonbmp_unicode_on_nix" # - AssertionError: '𝄞𝄞𝄞𝄞[91 chars]𝄞𝄞𝄞𝄞𝄞/𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞...
    "ShortFilenameTest::test_nonbmp_unicode_on_nix_with_windows_compat" # - AssertionError: '𝄞𝄞𝄞𝄞[85 chars]𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞/𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞𝄞' != '𝄞𝄞𝄞𝄞...
  ];

  setupPyGlobalFlags = [
    "build"
    "--disable-autoupdate"
    "--localedir=${placeholder "out"}/share/locale"
  ];

  nativeCheckInputs = [
    pythonPackages.pytestCheckHook
    writableTmpDirAsHomeHook
    cacert
  ];
  doCheck = true;

  # In order to spare double wrapping, we use:
  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
    makeWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version-regex"
      "release-(.*)"
    ];
  };

  meta = {
    homepage = "https://picard.musicbrainz.org";
    changelog = "https://picard.musicbrainz.org/changelog";
    description = "Official MusicBrainz tagger";
    mainProgram = "picard";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ doronbehar ];
  };
})
