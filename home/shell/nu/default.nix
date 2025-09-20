{ lib, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraEnv = ''
      $env.EDITOR = "${lib.getExe pkgs.helix}"
    '';
    shellAliases = {
      bottles-cli = "flatpak run --command=bottles-cli com.usebottles.bottles";
    };
  };
}
