# I used mmcblk0 as installer, so the target would be /dev/sda
{ config, lib, ... }:

let
  # Taken from nixos-raspberrypi-demo @ df753b7
  firmwarePartition = lib.recursiveUpdate {
    # label = "FIRMWARE";
    priority = 1;

    type = "0700"; # Microsoft basic data
    attributes = [
      0 # Required Partition
    ];

    size = "1024M";
    content = {
      type = "filesystem";
      format = "vfat";
      # mountpoint = "/boot/firmware";
      mountOptions = [
        "noatime"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=1min"
      ];
    };
  };
  espPartition = lib.recursiveUpdate {
    # label = "ESP";

    type = "EF00"; # EFI System Partition (ESP)
    attributes = [
      2 # Legacy BIOS Bootable, for U-Boot to find extlinux config
    ];

    size = "1024M";
    content = {
      type = "filesystem";
      format = "vfat";
      # mountpoint = "/boot";
      mountOptions = [
        "noatime"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=1min"
        "umask=0077"
      ];
    };
  };

  mountOptions = [
    "noatime"
    "compress=zstd"
  ];
in
{
  fileSystems."/var/log".neededForBoot = true;

  disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [
      "size=2G"
      "defaults"
      "mode=755"
    ];
  };

  disko.devices.disk.sdcard1 = {
    device = "/dev/sda";
    content = {
      type = "gpt";
      partitions = {
        FIRMWARE = firmwarePartition {
          label = "FIRMWARE";
          content.mountpoint = "/boot/firmware";
        };

        ESP = espPartition {
          label = "ESP";
          content.mountpoint = "/boot";
        };

        system = {
          type = "8305"; # Linux ARM64 root (/)

          size = "100%";
          content = {
            type = "btrfs";
            subvolumes = {
              "@nix" = {
                inherit mountOptions;
                mountpoint = "/nix";
              };
              "@home" = {
                inherit mountOptions;
                mountpoint = "/home";
              };
              "@log" = {
                inherit mountOptions;
                mountpoint = "/var/log";
              };
              "@swap" = {
                mountpoint = "/swap";
                swap."swapfile" = {
                  size = "8G";
                  priority = 3; # (higher number -> higher priority)
                  # to be used after zswap (set zramSwap.priority > this priority),
                  # but before "hibernation" swap
                  # https://github.com/nix-community/disko/issues/651
                };
              };
            };
          };
        }; # system
      };
    };
  };
}
