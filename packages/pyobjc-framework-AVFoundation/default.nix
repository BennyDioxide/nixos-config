{
  buildPythonPackage,
  callPackage,
  darwin,
  pyobjc-core,
  pyobjc-framework-CoreAudio,
  pyobjc-framework-Cocoa,
  pyobjc-framework-Quartz,
  setuptools,
}:
let
  pname = "pyobjc-framework-AVFoundation";
  pyobjc-framework-CoreMedia = callPackage ../pyobjc-framework-CoreMedia {
    inherit
      buildPythonPackage
      darwin
      pyobjc-core
      pyobjc-framework-Cocoa
      setuptools
      ;
  };
in
buildPythonPackage {
  inherit
    pname
    ;
  pyproject = true;

  inherit (pyobjc-core) version src;

  patches = pyobjc-core.patches or [ ];

  sourceRoot = "${pyobjc-core.src.name}/${pname}";

  build-system = [ setuptools ];

  buildInputs = [ darwin.libffi ];

  nativeBuildInputs = [ darwin.DarwinTools ];

  postPatch = ''
    substituteInPlace pyobjc_setup.py \
      --replace-fail "-buildversion" "-buildVersion" \
      --replace-fail "-productversion" "-productVersion" \
      --replace-fail "/usr/bin/sw_vers" "sw_vers" \
      --replace-fail "/usr/bin/xcrun" "xcrun"
  '';

  dependencies = [
    pyobjc-core
    pyobjc-framework-CoreMedia
    pyobjc-framework-CoreAudio
    pyobjc-framework-Cocoa
    pyobjc-framework-Quartz
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-I${darwin.libffi.dev}/include"
    "-Wno-error=unused-command-line-argument"
  ];

  pythonImportsCheck = [
    # No AVFAudio in 11.1
    # "AVFAudio"
    "AVFoundation"
    "PyObjCTools"
  ];
}
