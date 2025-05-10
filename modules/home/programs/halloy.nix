{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    mkOption
    ;

  cfg = config.programs.halloy;
  tomlFormat = pkgs.formats.toml { };
  configBaseDir =
    if pkgs.stdenv.hostPlatform.isDarwin then "Library/Application Support" else config.xdg.home;
in
{
  options.programs.halloy = {
    enable = lib.mkEnableOption "Halloy is an open-source IRC client written in Rust, with the iced GUI library";

    package = lib.mkPackageOption pkgs "halloy" { };

    settings = mkOption {
      type = tomlFormat.type;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file."${configBaseDir}/halloy/config.toml" = mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "halloy.toml" cfg.settings;
    };
  };
}
