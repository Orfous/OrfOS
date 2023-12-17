{ lib, config, ... }:

lib.mkIf config.hardware.mounts {
  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/99d9fc7b-2a21-42da-a05e-1f5881bb5081";
    fsType = "btrfs";
    options = lib.mkIf (config.hardware.btrfsCompression.enable
      && config.hardware.btrfsCompression.mounts) [ "compress=zstd" ];
  };

  fileSystems."/mnt/Harder Drive" = {
    device = "/dev/disk/by-uuid/0b17e5e9-a2f1-4350-b0e9-740187d016ce";
    fsType = "btrfs";
    options = lib.mkIf (config.hardware.btrfsCompression.enable
      && config.hardware.btrfsCompression.mounts) [ "compress=zstd" ];
  };
}
