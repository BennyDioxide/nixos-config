{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.mpv-handler;
in
{
  options.programs.mpv-handler = {
    enable = mkEnableOption "mpv-handler";

    package = mkOption {
      type = types.package;
      default = pkgs.mpv-handler;
    };

    mpvPackage = mkOption {
      type = types.package;
      default = pkgs.mpv;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
      cfg.mpvPackage
    ];
    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/mpv" = [ "mpv-handler.desktop" ];
      "x-scheme-handler/mpv-debug" = [ "mpv-handler-debug.desktop" ];
    };
  };
}
