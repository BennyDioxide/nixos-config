{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vulkan-tools
    mesa-demos # previously glxinfo
    # libGL
  ];
}
