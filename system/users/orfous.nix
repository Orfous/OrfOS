{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) optional;
  cfg = config.icedos;

  emulators =
    with pkgs;
    [
      # cemu # Wiuu
      # duckstation # PS1
      # pcsx2 # PS2
      # ppsspp # PSP
      # rpcs3 # PS3
    ]
    ++ optional (cfg.applications.suyu) inputs.switch-emulators.packages.${pkgs.system}.suyu;

  gaming = with pkgs; [
    heroic # Cross-platform Epic Games Launcher
    ludusavi # Game saves cloud backup with Nextcloud
    prismlauncher # Minecraft launcher
    protontricks # Winetricks for proton prefixes
    rclone # Sync to and from nextcloud
  ];
in
{
  users.users.orfous.packages =
    with pkgs;
    [
      bottles # Wine manager
      godot_4 # Game engine
      stremio # Media streaming platform
      spotify # Music streaming Service
      mullvad-vpn # The GUI client for mullvad
      nextcloud-client # Nextcloud themed desktop client
      bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager
      adw-gtk3 # Adds libadwaita support to GTK-3
      gradience# Customize libadwaita and GTK3 apps (with adw-gtk3)
      gsound # Small library for playing system sounds (required to show file properties in Nautilus)
      ungoogled-chromium # Chromium with dependencies on Google web services removed
      python311Packages.pandas # Python pandas packages
      python311Packages.pip
      xorg.xmodmap
      xorg.xev
      xkbset
      nodePackages_latest.gulp
      openssl_3_3
      obsidian
    ]
    ++ emulators
    ++ gaming;
}
