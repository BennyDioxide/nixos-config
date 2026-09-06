{
  buildPythonPackage,
  darwin,
  pyobjc-core,
  pyobjc-framework-Cocoa,
  setuptools,
}:
let
  pname = "pyobjc-framework-CoreMedia";
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
    pyobjc-framework-Cocoa
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-I${darwin.libffi.dev}/include"
    "-Wno-error=unused-command-line-argument"
  ];

  pythonImportsCheck = [
    "CoreMedia"
    "PyObjCTools"
  ];
}
