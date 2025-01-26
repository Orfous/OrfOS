{
  inputs = {
    # Update channels
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";

      follows = "chaotic/nixpkgs";

    };

    # Modules
    home-manager = {
      url = "github:nix-community/home-manager";

      follows = "chaotic/home-manager";

    };

    nerivations = {
      url = "github:icedborn/nerivations";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    steam-session = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      follows = "chaotic/jovian";
    };

    # Apps

    pipewire-screenaudio = {
      url = "github:IceDBorn/pipewire-screenaudio";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      home-manager,
      nerivations,
      nixpkgs,
      pipewire-screenaudio,
      self,

      chaotic,

      steam-session,

      ...
    }@inputs:
    {
      nixosConfigurations."desktop" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
        };

        modules = [
          # Read configuration location
          (
            { lib, ... }:
            let
              inherit (lib) mkOption types;
            in
            {
              options.icedos.configurationLocation = mkOption {
                type = types.str;
                default = "/home/orfous/dev/OrfOS";
              };
            }
          )

          # Symlink configuration state on "/run/current-system/source"
          {
            # Source: https://github.com/NixOS/nixpkgs/blob/5e4fbfb6b3de1aa2872b76d49fafc942626e2add/nixos/modules/system/activation/top-level.nix#L191
            system.extraSystemBuilderCmds = "ln -s ${self} $out/source";
          }

          # Internal modules
          (
            { lib, ... }:
            let
              inherit (lib) filterAttrs;

              getModules =
                path:
                builtins.map (dir: "/${path}/${dir}") (
                  builtins.attrNames (
                    filterAttrs (n: v: v == "directory" && !(n == "desktop" && path == ./system)) (
                      builtins.readDir path
                    )
                  )
                );
            in
            {
              imports = [
                ./hardware
                ./internals.nix
                ./options.nix
              ] ++ getModules (./system) ++ getModules (./hardware);

              config.system.stateVersion = "23.11";
            }
          )

          # External modules
          chaotic.nixosModules.default

          home-manager.nixosModules.home-manager
          nerivations.nixosModules.default

          ./system/desktop

          # Is First Build
          { icedos.internals.isFirstBuild = true; }

          ./system/desktop/gnome

          (
            # Do not modify this file!  It was generated by ‘nixos-generate-config’
            # and may be overwritten by future invocations.  Please make changes
            # to /etc/nixos/configuration.nix instead.
            {
              config,
              lib,
              pkgs,
              modulesPath,
              ...
            }:

            {
              imports = [
                (modulesPath + "/installer/scan/not-detected.nix")
              ];

              boot.initrd.availableKernelModules = [
                "nvme"
                "xhci_pci"
                "ahci"
                "usbhid"
                "usb_storage"
                "sd_mod"
              ];
              boot.initrd.kernelModules = [ ];
              boot.kernelModules = [ "kvm-amd" ];
              boot.extraModulePackages = [ ];

              fileSystems."/" = {
                device = "/dev/disk/by-uuid/2d2507f5-9d13-4580-9b63-7847206f17bb";
                fsType = "btrfs";
                options = [ "subvol=@" ];
              };

              boot.initrd.luks.devices."luks-12fedaa1-486a-4da2-acda-6f3b6c7d1d64".device = "/dev/disk/by-uuid/12fedaa1-486a-4da2-acda-6f3b6c7d1d64";

              fileSystems."/boot" = {
                device = "/dev/disk/by-uuid/0025-0666";
                fsType = "vfat";
              };

              swapDevices = [ ];

              # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
              # (the default) this is the recommended approach. When using systemd-networkd it's
              # still possible to use this option, but it's recommended to use it in conjunction
              # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
              networking.useDHCP = lib.mkDefault true;
              # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

              nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
              hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
            }
          )

          ({ })

        ];
      };
    };
}
