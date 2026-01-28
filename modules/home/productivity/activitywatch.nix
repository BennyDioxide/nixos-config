{ pkgs, ... }:

{
  services.activitywatch.enable = true;
  services.activitywatch.watchers = {
    awatcher.package = pkgs.awatcher;
  };
}
