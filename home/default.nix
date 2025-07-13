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
  imports =
    [
      ./shell
      ./mpv
      ./productivity
      ./kitty.nix
      ./font.nix
      ./cava.nix
      ./syncthing.nix
      ./editor/helix.nix
      ./editor/zed.nix
      ./java.nix
      ./irc.nix
      ./vcs.nix
      ../modules/home
    ]
    ++ lib.optionals (!isDarwin) [
      ./editor/vscode.nix
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
    LIBRARY_PATH = if isDarwin then "$LIBRARY_PATH:${pkgs.libiconv}/lib" else "";
  };

  systemd.user.sessionVariables = lib.mkIf (!isDarwin) {
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

  home.file.".cargo/config.toml".source =
    let
      linker = "${pkgs.clang}/bin/clang";
      rustflags =
        if isDarwin then
          [ ]
        else
          [
            "-C"
            "link-arg=-fuse-ld=${pkgs.mold-wrapped}/bin/mold"
          ];
    in
    (pkgs.formats.toml { }).generate "cargo-config" {
      build."rustc-wrapper" = "${pkgs.sccache}/bin/sccache";
      target.wasm32-unknown-unknown.runner = "${pkgs.wasm-pack}/bin/wasm-server-runner";
      target.x86_64-unknown-linux-gnu = { inherit linker rustflags; };
      target.aarch64-apple-darwin = { inherit linker; };
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
      extra-cmake-modules
      bazel
      ninja
      gettext
      mise
      just
      dust
      nixfmt-rfc-style
      nvd
      nix-tree
      nix-index
      # nix-init
      nh
      comma
      file
      gojq
      inshellisense
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
      superfile

      android-tools

      # manim
      # renpy
      # (callPackage ../pkgs/kde-material-you-colors {})
      pipx
      uv
      poetry
      qmk
      # cargo-sweep
      wasm-pack
      fortune
      pipes
      cmatrix
      cowsay
      figlet
      cbonsai

      imagemagick

      aria2
      xh
      yt-dlp
      ytarchive
      ffmpeg
      (if isDarwin then vlc-bin else vlc)
      audacity
      spotube
      # spotify
      # spotifyd
      # spotify-tui # Removed at Mar 12, 2024, 6:14 PM GMT+8
      # davinci-resolve

      pandoc

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
    ]
    ++ lib.optionals (!isDarwin) [
      libsForQt5.breeze-qt5
      libsForQt5.breeze-icons
      (hiPrio kdePackages.breeze)
      (hiPrio kdePackages.breeze-icons)
    ]
    ++ [
      # d-spy
      # dfeet
      kitty
      anki-bin
      # blender
      blockbench
      brave
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

      inkscape

      # Development

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
      # thefuck
      sheldon # zsh stuff for using warp
      colima
      lldb
      vscode-extensions.vadimcn.vscode-lldb
      python311Full
      # rust-bin
      (hiPrio rustup)
      wasm-bindgen-cli
      pkg-config
      dioxus-cli
      (hiPrio dotnet-sdk)
      dotnet-sdk_7
      nodejs
      yarn
      nodePackages.pnpm
      bun
      ghc
      haskell-language-server
      elan
      nixd
      nil
      nix-direnv
      devenv
      gradle
      sbcl
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

      musescore
      # (callPackage ../pkgs/pixitracker { })
      sunvox
      famistudio
    ]
    ++ lib.optionals (!isDarwin) [
      appimage-run

      # Not providing macOS ver for some reason
      rustdesk-flutter
      kdePackages.filelight
      krita
      jetbrains-toolbox

      # Broken on macOS
      (discord.override { withVencord = true; })
      zed-editor
      kiwix

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
      lilypond # Broken font
      # macOS framework issues
      gcc
      (hiPrio clang)
      clang-tools
      mold-wrapped # making it able to find libraries
      libGL
      (python3Full.withPackages (
        py-pkgs: with py-pkgs; [
          tkinter
          ipython
          material-color-utilities
          pywal
          # transformers
          # streamlit
        ]
      ))
      osu-lazer-bin # network issue or smth
      prismlauncher
      ferium
      modrinth-app

      qpwgraph
      jamesdsp
      playerctl

      wayland-utils
      ydotool
      vulkan-tools
      glxinfo
      bottles

      mangohud
      gamescope

      ardour
      # lmms
      bespokesynth-with-vst2
      drumgizmo
      lsp-plugins
      zam-plugins
      yabridge
      yabridgectl
    ];

  # programs.mpv-handler.enable = true;

  qt = lib.mkIf (!isDarwin) {
    enable = true;
    platformTheme.name = "qtct";
  };

  services.kdeconnect = lib.mkIf (!isDarwin) {
    enable = true;
    indicator = true;
  };

  # Enables xembed system tray available on Wayland
  services.xembed-sni-proxy.enable = !isDarwin;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
