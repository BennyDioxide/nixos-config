{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    mkPackageOption
    types
    defaultTo
    ;

  cfg = config.programs.rime-ls;

in
{
  options.programs.rime-ls = {
    enable = mkEnableOption "a language server that provides input method functionality using librime";

    package = mkPackageOption pkgs "rime-ls" { };
    rimePackage = mkPackageOption pkgs "fcitx5-rime" { };

    enableHelixIntegration = mkOption {
      type = types.bool;
      default = config.programs.helix.enable;
      description = "Whether to enable Helix editor integration";
    };

    settings = mkOption {
      type = types.submodule {
        options = {
          shared_data_dir = mkOption {
            type = types.str;
            default = "${cfg.rimePackage}/share/rime-data";
            description = "Shared/System wide RIME data";
          };

          user_data_dir = mkOption {
            type = types.str;
            default = "~/.local/share/rime-ls";
            description = "RIME user data";
          };

          log_dir = mkOption {
            type = types.str;
            default = cfg.settings.user_data_dir;
            description = "RIME log path";
          };

          trigger_characters = mkOption {
            type = types.listOf types.str;
            default = [ ];
            description = "Globally enable if empty, else trigger completion after specified characters";
          };

          schema_trigger_character = mkOption {
            type = types.str;
            default = "&";
            description = "Schema options trigger character";
          };

          paging_characters = mkOption {
            type = types.listOf types.str;
            default = [
              ","
              "."
              "-"
              "="
            ];
            description = "Characters of forcing triggering completion";
          };

          max_tokens = mkOption {
            type = types.int;
            default = 0;
          };

          always_incomplete = mkOption {
            type = types.bool;
            default = false;
          };

          preselect_first = mkOption {
            type = types.bool;
            default = false;
          };

          long_filter_text = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };

          show_filter_text_in_label = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };

          show_order_in_label = mkOption {
            type = types.bool;
            default = true;
          };
        };
      };
    };

  };

  config = mkIf (cfg.enable && cfg.enableHelixIntegration) {
    programs.helix.languages.language-server.rime-ls = {
      command = lib.getExe cfg.package;
      config =
        let
          inherit (cfg.settings) long_filter_text show_filter_text_in_label;
        in
        {
          inherit (cfg.settings)
            shared_data_dir
            user_data_dir
            log_dir
            trigger_characters
            schema_trigger_character
            paging_characters
            max_tokens
            always_incomplete
            preselect_first
            show_order_in_label
            ;

          long_filter_text = defaultTo true long_filter_text;
          show_filter_text_in_label = defaultTo false show_filter_text_in_label;
        };
    };
  };

}
