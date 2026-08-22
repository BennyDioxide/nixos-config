{ lib, pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      vulkan-tools
    ]
    ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
      mesa-demos # previously glxinfo
      # libGL
    ];
}
