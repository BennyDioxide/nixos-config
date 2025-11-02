{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.graalvmPackages.graalvm-ce; # pkgs.temurin-bin;
  };

  home.packages = with pkgs; [
    # jprofiler
    visualvm
  ];
}
