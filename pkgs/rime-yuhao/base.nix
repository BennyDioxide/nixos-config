{
  stdenvNoCC,
  fetchzip,

  schemaName,
  alias,
  hash,
}:

let
  version = "v3.9.0";
in
stdenvNoCC.mkDerivation {
  inherit version;
  pname = "yuhao-${schemaName}";

  src = fetchzip {
    inherit hash;
    url = "https://github.com/forfudan/yuhao-ime-release/releases/download/${version}/yuhao_${schemaName}_${alias}_${version}.zip";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    prefix=$out/share/rime-data

    mkdir -p $prefix
    cp -r schema/* $prefix
    rm $prefix/default.custom.yaml

    runHook postInstall
  '';
}
