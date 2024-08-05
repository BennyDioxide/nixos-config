{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.mpv-handler;
  settingsFormat = pkgs.formats.toml { };
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
      description = ''
        The mpv package to use.
      '';
    };

    ytdlPackage = mkOption {
      type = types.package;
      default = pkgs.yt-dlp;
      description = ''
        The yt-dlp package to use.
      '';
    };

    proxy = mkOption {
      type = types.str;
      default = "";
      description = ''
        The proxy server address
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."mpv-handler/config.toml".source = settingsFormat.generate "config.toml" {
      mpv = meta.getExe cfg.mpvPackage;
      ytdl = meta.getExe cfg.ytdlPackage;
      inherit (cfg) proxy;
    };

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/mpv" = [ "mpv-handler.desktop" ];
      "x-scheme-handler/mpv-debug" = [ "mpv-handler-debug.desktop" ];
    };
  };
}
