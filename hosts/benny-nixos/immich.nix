{ config, ... }:

{
  services.immich.enable = true;
  services.immich.mediaLocation = "/mnt/segate4t/Pictures/immich";
  services.immich.openFirewall = true;
  services.immich.host = "0.0.0.0";

  # Accelerated Video Playback
  services.immich.accelerationDevices = null; # Accelerate all
  # hardware.graphics = {};
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.nginx.virtualHosts."immich.bdioxide.me" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://[::1]:${config.services.immich.port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
}
