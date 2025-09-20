{ config, ... }:
{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraEnv = ''
      $env.EDITOR = ${config.home.sessionVariables.EDITOR}
    '';
    shellAliases = {
      bottles-cli = "flatpak run --command=bottles-cli com.usebottles.bottles";
    };
  };
}
