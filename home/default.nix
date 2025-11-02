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
    ./development
    ./editor
    ./education
    ./font.nix
    ./game
    ./graphics.nix
    ./kitty.nix
    ./multimedia
    ./networking
    ./productivity
    ./shell
    ../modules/home
  ]
  ++ lib.optionals (!isDarwin) [
    ./gtk.nix
    ./wine
    ./wm
    ./xdg
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

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

  home.packages =
    with pkgs;
    [
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

      fortune
      pipes
      # cmatrix
      # cowsay
      # figlet
      # cbonsai
    ]
    ++ lib.optionals isDarwin [
      raycast
    ]
    ++ [
      # d-spy
      # dfeet
      scrcpy
      # (callPackage appimageTools.wrapType2 {
      #   name = "oxwu";
      #   src = fetchurl {
      #     url = "https://eew.earthquake.tw/releases/linux/x64/oxwu-linux-x86_64.AppImage";
      #     sha256 = "sha256-UthNGrFT6G09UkCwirjH9jgd1+ExRmt6KnD43JdkaDE=";
      #   };
      # })

    ]
    ++ lib.optionals (!isDarwin) [
      appimage-run

      organicmaps

      # Not providing macOS ver for some reason
      rustdesk-flutter
      kdePackages.filelight
      # kiwix

      # lilypond # Broken font
      # macOS framework issues
    ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
