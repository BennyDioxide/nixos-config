{ lib, pkgs, ... }:

{
  imports = [
    ./xdg
    ./shell
    ./wm
    ./mpv
    ./font.nix
    ./kitty.nix
    ./cava.nix
    ./syncthing.nix
    ./helix.nix
    ./vscode.nix
    ./java.nix
    ./gtk.nix
    ../modules/home
  ];

  home.username = "benny";
  home.homeDirectory = "/home/benny";

  # nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    userName = "BennyDioxide";
    userEmail = "bennystyang@proton.me";
    extraConfig = {
      core.editor = "hx";
      core.autocrlf = "input";
      credential.helper = "store";
      color.ui = "auto";
      filter.lfs = {
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
      };
    };
  };

  systemd.user.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
    NIX_BUILD_SHELL = "zsh";
    LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    GTK_USE_PORTAL = 1;
    # QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
    PKG_CONFIG_PATH =
      with pkgs;
      lib.lists.foldl (a: b: "${a}:${b}/lib/pkgconfig") "~/.nix-profile/lib/pkgconfig" [
        xdotool
        (alsa-lib.dev)
        (udev.dev)
        (wayland.dev)
        (libxkbcommon.dev)
        (openssl.dev)
      ];
  };

  home.file.".cargo/config.toml".source = (pkgs.formats.toml { }).generate "cargo-config" {
    # build."rustc-wrapper" = "${pkgs.sccache}/bin/sccache";
    target.wasm32-unknown-unknown.runner = "${pkgs.wasm-pack}/bin/wasm-server-runner";
    target.x86_64-unknown-linux-gnu.linker = "${pkgs.clang}/bin/clang";
    target.x86_64-unknown-linux-gnu.rustflags = [
      "-C"
      "link-arg=-fuse-ld=${pkgs.mold-wrapped}/bin/mold"
    ];
  };

  home.packages =
    with pkgs;
    [
      gitui
      gh
      # gitbutler
      gnumake
      cmake
      extra-cmake-modules
      bazel
      ninja
      gettext
      mise
      dust
      nixpkgs-fmt
      nvd
      nix-tree
      # nix-init
      file
      gojq
      inshellisense
      appimage-run
      unzip
      p7zip
      trash-cli
      hyperfine
      navi
      # manim
      # renpy
      # (callPackage ../pkgs/kde-material-you-colors {})
      python311
      (hiPrio python3)
      (python3.withPackages (
        py-pkgs: with py-pkgs; [
          ipython
          material-color-utilities
          pywal
          transformers
          # streamlit
        ]
      ))
      pipx
      poetry
      qmk
      direnv
      # cargo-sweep
      wasm-pack

      fortune
      pipes
      cmatrix
      cowsay
      figlet
      cbonsai

      aria2
      xh
      yt-dlp
      ytarchive
      ffmpeg
      vlc
      audacity
      # spotify
      # spotifyd
      # spotify-tui # Removed at Mar 12, 2024, 6:14 PM GMT+8
      qpwgraph
      jamesdsp
      playerctl
      # davinci-resolve

      libreoffice
      texlive.combined.scheme-full
      texstudio
      pandoc

      wayland-utils
      vulkan-tools
      glxinfo
      # wine
      # wineWowPackages.waylandFull
      # wineWowPackages.stable
      # wineWowPackages.stableFull
      wineWowPackages.stagingFull
      bottles

      obs-studio
      dex
    ]
    ++ (with libsForQt5; [
      breeze-qt5
      breeze-icons
    ])
    ++ (with kdePackages; [
      (hiPrio kdePackages.breeze)
      (hiPrio breeze-icons)
    ])
    ++ [
      ydotool
      # d-spy
      # dfeet
      (discord.override { withVencord = true; })
      kitty
      anki-bin
      # blender
      blockbench
      brave
      # (
      #   let
      #     pname = "logseq";
      #     version = "0.10.10-alpha+nightly.20240815";
      #   in
      #   (logseq.override { electron = electron_28; }).overrideAttrs {
      #     inherit pname version;
      #     src = fetchurl {
      #       url = "https://github.com/logseq/logseq/releases/download/nightly/logseq-linux-x64-${version}.AppImage";
      #       hash = "sha256-SeEBS1wGnHH0dJ9h4sMl+zFiTk2GDZXNItqasFFTcIQ=";
      #       name = "${pname}-${version}.AppImage";
      #     };
      #   }
      # )
      logseq
      # geogebra
      telegram-desktop
      # element-desktop
      rustdesk
      scrcpy
      localsend
      filelight
      # (callPackage appimageTools.wrapType2 {
      #   name = "oxwu";
      #   src = fetchurl {
      #     url = "https://eew.earthquake.tw/releases/linux/x64/oxwu-linux-x86_64.AppImage";
      #     sha256 = "sha256-UthNGrFT6G09UkCwirjH9jgd1+ExRmt6KnD43JdkaDE=";
      #   };
      # })

      # Zed editor
      zed-editor

      krita
      inkscape

      # Development

      jetbrains-toolbox
      # jetbrains.rust-rover
      # jetbrains.rider
      # jetbrains.clion
      # jetbrains.pycharm-professional
      # jetbrains.pycharm-community
      # jetbrains.idea-professional
      # jetbrains.idea-community
      # android-studio-full
      # androidStudioPackages.beta

      # lapce
      neovide
      warp-terminal
      thefuck
      sheldon # zsh stuff for using warp
      (hiPrio clang)
      lldb
      gcc
      clang-tools
      mold-wrapped # making it able to find libraries
      vscode-extensions.vadimcn.vscode-lldb
      # rust-bin
      (hiPrio rustup)
      pkg-config
      libGL
      dioxus-cli
      (hiPrio dotnet-sdk)
      dotnet-sdk_7
      nodejs
      yarn
      nodePackages.pnpm
      bun
      ghc
      haskell-language-server
      nixd
      nil
      nix-direnv
      devenv
      gradle
      clojure
      clojure-lsp
      babashka
      marksman
      zig
      zls
      bqn
      pyright
      # vscode-langservers-extracted # nodePackages.vscode-json-languageserver-bin
      nodePackages.typescript-language-server
      # lua54Packages.luasocket # For ~/.config/fcitx5/addon/kanata/lib.lua

      osu-lazer-bin
      prismlauncher
      mangohud
      gamescope
      ferium
      modrinth-app

      musescore
      ardour
      # (callPackage ../pkgs/pixitracker { })
      sunvox
      famistudio
      lmms
      bespokesynth-with-vst2
      drumgizmo
      lsp-plugins
      zam-plugins
      yabridge
      yabridgectl
    ];

  programs.mpv-handler.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Enables xembed system tray available on Wayland
  services.xembed-sni-proxy.enable = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
