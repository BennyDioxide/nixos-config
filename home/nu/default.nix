{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    environmentVariables = {
      EDITOR = "hx";
    };
    shellAliases = {
      bottles-cli = "flatpak run --command=bottles-cli com.usebottles.bottles";
    };
  };
}
