{ lib, pkgs, isDarwin, ... }:

{
  imports = [
    ./java.nix
    ./vcs.nix
  ];

  programs.direnv.enable = true;

  home.file.".cargo/config.toml".source =
    let
      # linker = lib.getExe pkgs.clang;
      # rustflags = lib.optionals (!isDarwin) [
      #   "-C"
      #   "link-arg=-fuse-ld=${lib.getExe pkgs.mold-wrapped}"
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

  home.packages = with pkgs; [
    gitu
    gitui
    gh
    # gitbutler
    gnumake
    xmake
    cmake
    boost
    # extra-cmake-modules
    bazel
    ninja
    gettext
    # mise

    # lapce
    # neovide
    # warp-terminal
    # thefuck
    # sheldon # zsh stuff for using warp
    colima
    lldb
    vscode-extensions.vadimcn.vscode-lldb
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
    # rust-bin
    rustup
    wasm-bindgen-cli
    pkg-config
    dioxus-cli
    # dotket-sdk
    # dotnet-sdk_7
    nodejs
    yarn
    nodePackages.pnpm
    bun
    # ghc
    # haskell-language-server
    # elan
    # nixd
    nil
    nix-direnv
    # devenv
    gradle
    sbcl
    steel
    clojure
    clojure-lsp
    babashka
    marksman
    zig
    zls
    # bqn
    pyright
    # vscode-langservers-extracted # nodePackages.vscode-json-languageserver-bin
    nodePackages.typescript-language-server

    android-tools

    # manim
    # renpy
    # (callPackage ../pkgs/kde-material-you-colors {})
    pipx
    uv
    # poetry
    # qmk
    # cargo-sweep
    wasm-pack
  ] ++ lib.optionals (!isDarwin) [
    # gcc
    # (lib.hiPrio clang)
    # clang-tools
    mold-wrapped # making it able to find libraries
  ];
}
