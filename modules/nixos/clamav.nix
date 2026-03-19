{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.clamav
    pkgs.clamtk
  ];
  services.clamav.daemon.enable = true;
  services.clamav.scanner.enable = true;
  services.clamav.updater.enable = true;
  services.clamav.fangfrisch.enable = true;

  services.clamav.clamonacc.enable = true;
  services.clamav.daemon.settings.OnAccessPrevention = true;
}
