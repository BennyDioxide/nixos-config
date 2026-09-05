{ lib, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    environmentVariables = {
      CARAPACE_BRIDGES = "zsh,bash";
      EDITOR = "${lib.getExe pkgs.helix}";
    };
    shellAliases = {
      bottles-cli = "flatpak run --command=bottles-cli com.usebottles.bottles";
    };
    settings = {
      edit_mode = "helix";
      highlight_resolved_externals = true;
    };
  };
}
