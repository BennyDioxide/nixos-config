{ pkgs, ... }:
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
    ./programs/rime-ls.nix
    ./programs/mpv-handler.nix
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    PATH = "~/.cargo/bin:~/.local/bin:$PATH";
  };

  home.packages = with pkgs; [
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

    ghostty

    fortune
    pipes
    # cmatrix
    # cowsay
    # figlet
    # cbonsai

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

  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
