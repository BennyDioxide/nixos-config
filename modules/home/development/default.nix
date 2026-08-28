{
  flake,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin system;
in
{
  imports = [
    ./dotnet.nix
    ./java.nix
    ./lua.nix
    ./unison.nix
    ./vcs.nix
  ];

  programs.direnv.enable = true;
  programs.devenv.enable = true;

  home.file.".cargo/config.toml".source =
    let
      # linker = lib.getExe pkgs.clang;
      # rustflags = lib.optionals (!isDarwin) [
      #   "-C"
      #   "link-arg=-fuse-ld=${lib.getExe pkgs.mold}"
      # ];
      format = pkgs.formats.toml { };
    in
    format.generate "cargo-config" {
      # build."rustc-wrapper" = lib.getExe pkgs.sccache;

      # non-existant wasm-pack/bin/wasm-server-runner
      # target.wasm32-unknown-unknown.runner = lib.getExe' pkgs.wasm-pack "wasm-server-runner";
      # target.x86_64-unknown-linux-gnu = { inherit linker rustflags; };
      # target.aarch64-apple-darwin = { inherit linker; };
    };

  home.packages =
    with pkgs;
    [
      # gitu
      gitui
      gh
      gnumake
      xmake
      # mise
      flake.inputs.magix.packages.${system}.magix

      (python3.withPackages (
        py-pkgs: with py-pkgs; [
          tkinter
          # ipython
          material-color-utilities
          pywal
          # transformers
          # streamlit
        ]
      ))
      yarn
      pnpm # nodePackages removed
      # elan
      nil
      babashka
      marksman

      android-tools

      # manim
      # renpy
      # (callPackage ../pkgs/kde-material-you-colors {})
      uv
      # qmk
      # cargo-sweep
    ]
    ++ lib.optionals (!isDarwin) [
      mold

      qt6.qtbase # Shitty way to make Qt happy
    ];
}
