{
  lib,
  pkgs,
  isDarwin ? false,
  ...
}:

let
  username = if isDarwin then "bennyyang" else "benny";
  homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
in
{
  imports = [
    ./shell
    ./mpv
    ./productivity
    ./networking
    ./kitty.nix
    ./font.nix
    ./cava.nix
    ./editor
    ./java.nix
    ./vcs.nix
    ../modules/home
  ]
  ++ lib.optionals (!isDarwin) [
    ./xdg
    ./wm
    ./gtk.nix
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  # nixpkgs.config.allowUnfree = true;

  programs.direnv.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
    PATH = "~/.cargo/bin:~/.local/bin:$PATH";
  }
  // lib.mkIf isDarwin {
    LIBRARY_PATH = "$LIBRARY_PATH:${pkgs.libiconv}/lib";
  };

  systemd.user.sessionVariables = lib.mkIf (!isDarwin) {
    NIXPKGS_ALLOW_UNFREE = 1;
    NIX_BUILD_SHELL = "zsh";
    LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    GTK_USE_PORTAL = 1;
    # QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
  };

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

  home.packages =
    with pkgs;
    [
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
      just
      dust
      nixfmt-rfc-style
      nvd
      nix-tree
      nix-index
      # nix-init
      nh
      comma
      # file
      gojq
      # inshellisense
      unzip
      p7zip
      trash-cli
      hyperfine
      navi
      xh
      neovim
      eza
      ripgrep
      fd
      bat
      tealdeer
      delta
      btop
      bottom
      gopass
      # superfile

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
      fortune
      pipes
      # cmatrix
      # cowsay
      # figlet
      # cbonsai

      # imagemagick

      aria2
      xh
      yt-dlp
      ytarchive
      ffmpeg
      (if isDarwin then vlc-bin else vlc)
      # audacity
      spotube
      # spotify
      # spotifyd
      # spotify-tui # Removed at Mar 12, 2024, 6:14 PM GMT+8
      # davinci-resolve

      # pandoc

    ]
    ++ lib.optionals isDarwin [
      raycast
    ]
    ++ lib.optionals (!isDarwin) [
      # wine
      # wineWowPackages.waylandFull
      # wineWowPackages.stable
      # wineWowPackages.stableFull
      wineWowPackages.stagingFull

      obs-studio
      dex
      kdePackages.breeze
      kdePackages.breeze-icons
    ]
    ++ [
      # d-spy
      # dfeet
      kitty
      anki-bin
      # blender
      # blockbench
      # brave
      # geogebra
      telegram-desktop
      # element-desktop
      scrcpy
      localsend
      # (callPackage appimageTools.wrapType2 {
      #   name = "oxwu";
      #   src = fetchurl {
      #     url = "https://eew.earthquake.tw/releases/linux/x64/oxwu-linux-x86_64.AppImage";
      #     sha256 = "sha256-UthNGrFT6G09UkCwirjH9jgd1+ExRmt6KnD43JdkaDE=";
      #   };
      # })

      # prismlauncher
      ferium
      # modrinth-app

      # inkscape

      # Development

      # jetbrains.rust-rover
      jetbrains.rider
      # jetbrains.clion
      # jetbrains.pycharm-professional
      # jetbrains.pycharm-community
      # jetbrains.idea-professional
      # jetbrains.idea-community
      # android-studio-full
      # androidStudioPackages.beta

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
      (hiPrio rustup)
      wasm-bindgen-cli
      pkg-config
      dioxus-cli
      # (hiPrio dotnet-sdk)
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
      # lua54Packages.luasocket # For ~/.config/fcitx5/addon/kanata/lib.lua

      musescore
      # (callPackage ../pkgs/pixitracker { })
      # sunvox
      # famistudio
    ]
    ++ lib.optionals (!isDarwin) [
      appimage-run

      # Not providing macOS ver for some reason
      rustdesk-flutter
      kdePackages.filelight
      krita
      jetbrains-toolbox
      unityhub

      # Broken on macOS
      zed-editor
      # kiwix

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
      # lilypond # Broken font
      # macOS framework issues
      # gcc
      # (hiPrio clang)
      # clang-tools
      mold-wrapped # making it able to find libraries
      # libGL
      osu-lazer-bin # network issue or smth
      # modrinth-app

      qpwgraph
      jamesdsp
      playerctl

      wayland-utils
      ydotool
      vulkan-tools
      glxinfo
      bottles

      mangohud
      # gamescope

      ardour
      # lmms
      bespokesynth-with-vst2
      drumgizmo
      calf
      dragonfly-reverb
      vital
      lsp-plugins
      x42-plugins
      x42-gmsynth
      geonkick
      zam-plugins
      yabridge
      yabridgectl
    ];

  # programs.mpv-handler.enable = true;

  qt = lib.mkIf (!isDarwin) {
    enable = true;
    platformTheme.name = "qtct";
  };

  services.syncthing.enable = isDarwin;

  # Enables xembed system tray available on Wayland
  services.xembed-sni-proxy.enable = !isDarwin;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
