{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  dbus,
  openssl,
  xz,
  bzip2,
  systemdLibs,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "wsu";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "mistrmochov";
    repo = "WaydroidSU";
    rev = finalAttrs.version;
    hash = "sha256-ICC/lTUSUpeg/RZOfLJzplt3aQBXlNg1ng8yANGVMgA=";
  };

  cargoHash = "sha256-kweqiD7UyS8Tm9bPvjGx6V91uUf2xLQtxw5L5frFuOw=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    dbus
    openssl
    xz
    bzip2
    systemdLibs
  ];

  meta = {
    description = "A CLI Magisk manager and installer for Waydroid";
    homepage = "https://github.com/mistrmochov/WaydroidSU";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
  };
})
