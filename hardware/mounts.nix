{ lib, config, ... }:

let
  inherit (lib) mkIf;

  cfg = config.icedos.hardware;
  btrfsCompression = cfg.btrfsCompression;
in mkIf (cfg.mounts) {
  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/99d9fc7b-2a21-42da-a05e-1f5881bb5081";
    fsType = "btrfs";
    options = mkIf (btrfsCompression.enable && btrfsCompression.mounts)
      [ "compress=zstd" ];
  };

  fileSystems."/mnt/Harder Drive" = {
    device = "/dev/disk/by-uuid/0b17e5e9-a2f1-4350-b0e9-740187d016ce";
    fsType = "btrfs";
    options = mkIf (btrfsCompression.enable && btrfsCompression.mounts)
      [ "compress=zstd" ];
  };

  #   fileSystems."/mnt/Softer Drive" = {
  #     device = "/dev/disk/by-uuid/5febf70b-0510-4efc-9431-f104ea0eaa16";
  #     encrypted = {
  #       enable = true;
  #       blkDev = "/dev/disk/by-uuid/0811fc67-2d1f-4d86-b681-e63b4747d47a";
  #     };
  #     fsType = "auto";
  #   };
}
