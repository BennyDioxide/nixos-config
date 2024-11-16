{ pkgs, config, ... }:
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    environmentVariables = with config.home; {
      EDITOR = "\"hx\"";
      PNPM_HOME = "\"${homeDirectory}/.local/share/pnpm\"";
      ANDROID_HOME = "\"${homeDirectory}/Android/Sdk\"";
    };
    shellAliases = {
      bottles-cli = "flatpak run --command=bottles-cli com.usebottles.bottles";
    };
  };
}
