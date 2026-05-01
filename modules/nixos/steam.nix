{
  flake,
  config,
  ...
}:
{
  imports = [
    flake.inputs.steam-presence.nixosModules.steam-presence
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    presence.enable = true;
    presence.userIds = [ "76561199228879259" ];
    presence.steamApiKeyFile = config.age.secrets.steam.path;
  };
}
