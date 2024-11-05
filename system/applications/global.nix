{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:

let
  inherit (lib) foldl' lists splitString;

  pkgMapper =
    pkgList: lists.map (pkgName: foldl' (acc: cur: acc.${cur}) pkgs (splitString "." pkgName)) pkgList;

  pkgFile = lib.importTOML ./packages.toml;
  myPackages = (pkgMapper pkgFile.myPackages);
  codingDeps = (pkgMapper pkgFile.codingDeps);

  # Logout from any shell
  lout = pkgs.writeShellScriptBin "lout" ''
    pkill -KILL -u $USER
  '';

  rebuild = import modules/rebuild.nix {
    inherit pkgs config;
    command = "rebuild";
    update = "false";
  };

  toggle-services = import modules/toggle-services.nix { inherit pkgs; };

  # Trim NixOS generations
  trim-generations = pkgs.writeShellScriptBin "trim-generations" (
    builtins.readFile ../../scripts/trim-generations.sh
  );

  shellScripts = [
    inputs.shell-in-netns.packages.${pkgs.system}.default
    lout
    rebuild
    toggle-services
    trim-generations
  ];

    aagl-gtk-on-nix = import (
    builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz"
  );

in
{
  imports = [
    ./modules/android-tools.nix
    ./modules/aria2c.nix
    ./modules/bash.nix
    ./modules/brave.nix
    ./modules/btop
    ./modules/celluloid
    ./modules/clamav.nix
    ./modules/codium
    ./modules/container-manager.nix
    ./modules/gamemode.nix
    ./modules/garbage-collect
    ./modules/gdm.nix
    ./modules/git.nix
    ./modules/kernel.nix
    ./modules/kitty.nix
    ./modules/librewolf
    ./modules/libvirtd.nix
    ./modules/mangohud.nix
    ./modules/nvchad
    ./modules/php.nix
    ./modules/pitivi.nix
    ./modules/solaar.nix
    ./modules/steam.nix
    ./modules/sunshine.nix
    ./modules/tailscale.nix
    ./modules/tmux
    ./modules/waydroid.nix
    ./modules/yazi.nix
    ./modules/zed
    ./modules/zsh

    # Enable Genshin Impact launcher
    aagl-gtk-on-nix.module
  ];


  programs.anime-game-launcher.enable = true;
  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };

  environment.systemPackages =
    (pkgMapper pkgFile.packages) ++ myPackages ++ codingDeps ++ shellScripts;

  programs = {
    direnv.enable = true;
  };

  services = {
    mullvad-vpn.enable = true;
    openssh.enable = true;
    fwupd.enable = true;
  };
}
