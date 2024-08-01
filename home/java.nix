{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.temurin-bin;
  };

  home.packages = with pkgs; [
    # jprofiler
    visualvm
  ];
}
