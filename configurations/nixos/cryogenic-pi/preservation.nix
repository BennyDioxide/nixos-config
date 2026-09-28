{ flake, ... }:
let
  root = "/nix/persistent";
in
{
  imports = [ flake.inputs.preservation.nixosModules.default ];
  preservation.enable = true;
  preservation.preserveAt.${root} = {
    files = [
      {
        file = "/etc/machine-id";
        inInitrd = true;
      }
      {
        file = "/etc/ssh/ssh_host_rsa_key";
        how = "symlink";
        configureParent = true;
      }
      {
        file = "/etc/ssh/ssh_host_ed25519_key";
        how = "symlink";
        configureParent = true;
      }
    ];
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/systemd/timers"
      # NixOS user state
      "/var/lib/nixos"
      "/var/lib/bluetooth"
    ];
    users.root = {
      home = "/root";
      directories = [
        {
          directory = ".ssh";
          "mode" = "0700";
        }
      ];
    };
  };

  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

  # let the service commit the transient ID to the persistent volume
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "${root}/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root ${root}"
    ];
  };
}
