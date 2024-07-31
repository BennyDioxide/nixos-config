{ pkgs, ... }:

{
  imports = [
    ./font.nix
    ./cava.nix
    ./gtk.nix
  ];

  home.username = "benny";
  home.homeDirectory = "/home/benny";

  nixpkgs.config.allowUnfree = true;

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
      ninja
      gettext
      mise
      dust
      nixpkgs-fmt
      nvd
      nix-tree
      file
      gojq
      inshellisense
      appimage-run
      unzip
      p7zip
      hyperfine
      xh
      manim
      # renpy
      # (callPackage ../pkgs/kde-material-you-colors {})
      (python3.withPackages (
        py-pkgs: with py-pkgs; [
          ipython
          material-color-utilities
          pywal
          transformers
          streamlit
        ]
      ))
      pipx
      poetry
      qmk
      direnv
      cargo-sweep

      aria2
      yt-dlp
      ffmpeg
      vlc
      # spotify
      # spotifyd
      # spotify-tui # Removed at Mar 12, 2024, 6:14 PM GMT+8
      qpwgraph
      jamesdsp
      playerctl

      libreoffice
      pandoc

      wayland-utils
      vulkan-tools
      glxinfo
      # wine
      # wineWowPackages.waylandFull
      # wineWowPackages.stable
      wineWowPackages.stableFull
      bottles

      obs-studio
      dex
      cava
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
      blender
      blockbench
      brave
      # logseq
      # geogebra
      telegram-desktop
      element-desktop
      rustdesk
      scrcpy
      # localsend
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

      jetbrains-toolbox
      # lapce
      # warp-terminal
      # (callPackage ../pkgs/warp-terminal { })
      zsh
      thefuck
      sheldon # zsh stuff for using warp
      (hiPrio clang)
      # libclang
      # libllvm
      lldb
      gcc
      (hiPrio rustup)
      pkg-config
      libGL
      dioxus-cli
      # (hiPrio dotnet-sdk)
      # dotnet-sdk_7
      nodejs
      yarn
      nodePackages.pnpm
      bun
      ghc
      haskell-language-server
      nixd
      nil
      gradle
      clojure
      clojure-lsp
      babashka
      marksman
      zig
      zls
      bqn
      pyright
      vscode-langservers-extracted # nodePackages.vscode-json-languageserver-bin
      nodePackages.typescript-language-server
      # lua54Packages.luasocket # For ~/.config/fcitx5/addon/kanata/lib.lua

      osu-lazer-bin
      prismlauncher
      mangohud
      gamescope
      ferium
      # (callPackage appimageTools.wrapType2 {
      #   name = "modrinth-app";
      #   src = fetchurl {
      #     url = "https://launcher-files.modrinth.com/versions/0.6.3/linux/modrinth-app_0.6.3_amd64.AppImage";
      #     sha256 = "sha256-MlYU3I4syM199J6zW+WeLBnMowUdf09KqPJAE1sY7kU=";
      #   };
      # })

      musescore
      ardour
      # (callPackage ../pkgs/pixitracker { })
      sunvox
      famistudio
      lmms
      # (callPackage appimageTools.wrapType2 rec {
      #   name = "lmms-appimage";
      #   version = "1.2.2";
      #   src = fetchurl {
      #     url = "https://github.com/LMMS/lmms/releases/download/v${version}/lmms-${version}-linux-x86_64.AppImage";
      #     sha256 = "sha256-bNxFoGmbjNhSlcSbysA/zObz2P/X2iPWRtDLQliGm3Y=";
      #   };
      # })
      bespokesynth-with-vst2
      lsp-plugins
      zam-plugins
      yabridge
      yabridgectl
    ];

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = { };
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };

  qt = {
    enable = true;
    style = {
      name = "breeze";
      package =
        with pkgs;
        (with libsForQt5; [
          breeze-qt5
          breeze-icons
        ])
        ++ (with kdePackages; [
          (hiPrio kdePackages.breeze)
          (hiPrio breeze-icons)
        ]);
    };
    platformTheme = "qtct";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
