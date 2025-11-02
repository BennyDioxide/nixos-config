{ lib, pkgs, isDarwin, ... }:

{
  home.packages = with pkgs; lib.optionals (!isDarwin) [
    vulkan-tools
    mesa-demos # previously glxinfo
    # libGL
  ];
}
