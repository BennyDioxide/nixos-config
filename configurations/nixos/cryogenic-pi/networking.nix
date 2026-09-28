{
  networking.hostName = "cryogenic-pi";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.backend = "iwd";

  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General.AddressRandomization = "network";
    Network.EnableIPv6 = true;
    Settings.AutoConnet = true;
  };
}
