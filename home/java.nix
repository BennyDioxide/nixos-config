{ pkgs, ... }:

{
  programs.java = {
    enable = false;
    package = pkgs.graalvm-ce; # pkgs.temurin-bin;
  };

  home.packages = with pkgs; [
    # jprofiler
    visualvm
  ];
}
