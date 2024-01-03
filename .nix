{ lib, ... }:

{
  options = with lib; {
    applications = {
      firefox = {
        gnomeTheme = mkOption {
          type = types.bool;
          default = false;
        };

        privacy = mkOption {
          type = types.bool;
          default = false;
        };

        # Sites to launch on Firefox PWAs
        pwas.sites = mkOption {
          type = types.str;
          default =
            "https://app.tuta.com https://icedborn.github.io/icedchat https://discord.com/app";
        };
      };

      nvchad.formatOnSave = mkOption {
        type = types.bool;
        default = true;
      };

      # Hide kitty top bar
      kitty.hideDecorations = mkOption {
        type = types.bool;
        default = true;
      };

      steam = {
        # Extras to use for adwaita for steam theme
        adwaitaForSteam.extras = mkOption {
          type = types.str;
          default = "-e login/hover_qr";
        };

        beta = mkOption {
          type = types.bool;
          default = true;
        };

        # Workaround for slow steam downloads
        downloadsWorkaround = mkOption {
          type = types.bool;
          default = true;
        };

        session = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          autoStart = {
            enable = mkOption {
              type = types.bool;
              default = false;
            };

            desktopSession = mkOption {
              type = types.str;
              default = "hyprland";
            };
          };

          steamdeck = mkOption {
            type = types.bool;
            default = false;
          };
        };
      };
    };

    boot = {
      # Hides startup text and displays a circular loading icon
      animation = mkOption {
        type = types.bool;
        default = false;
      };

      grub = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };

        device = mkOption {
          type = types.str;
          default = "/dev/sda";
        };
      };

      systemd-boot = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };

        efi-mount-path = mkOption {
          type = types.str;
          default = "/boot";
        };
      };

      # Used for rebooting to windows with efibootmgr
      windowsEntry = mkOption {
        type = types.str;
        default = "0000";
      };
    };

    desktop = {
      autologin = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };

        # If false, defaults to work user
        main.user.enable = mkOption {
          type = types.bool;
          default = true;
        };
      };

      gdm = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };

        autoSuspend = mkOption {
          type = types.bool;
          default = true;
        };
      };

      gnome = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };

        arcmenu = mkOption {
          type = types.bool;
          default = false;
        };

        caffeine = mkOption {
          type = types.bool;
          default = true;
        };

        clockDate = mkOption {
          type = types.bool;
          default = false;
        }; # Show the month and day of the month on the clock

        clockWeekday = mkOption {
          type = types.bool;
          default = false;
        }; # Show the day of the week on the clock

        dashToPanel = mkOption {
          type = types.bool;
          default = false;
        };

        gsconnect = mkOption {
          type = types.bool;
          default = true;
        };

        hotCorners = mkOption {
          type = types.bool;
          default = true;
        };

        # Whether to set (or unset) gnome's and arcmenu's pinned apps
        pinnedApps = mkOption {
          type = types.bool;
          default = false;
        };

        powerButtonAction = mkOption {
          type = types.str;
          default = "interactive";
        };

        startupItems = mkOption {
          type = types.bool;
          default = false;
        };

        # Options: 'minimize', 'maximize', 'close', 'spacer'(adds space between buttons), ':'(left-center-right separator)
        titlebarLayout = mkOption {
          type = types.str;
          default = "appmenu:minimize,close";
        };

        workspaces = {
          dynamicWorkspaces = mkOption {
            type = types.bool;
            default = false;
          };

          # Determines the maximum number of workspaces when dynamic workspaces are disabled
          maxWorkspaces = mkOption {
            type = types.str;
            default = "1";
          };
        };
      };

      hypr = mkOption {
        type = types.bool;
        default = true;
      };

      hyprland = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };

        lock = {
          secondsToLock = mkOption {
            type = types.str;
            default = "180";
          };

          secondsToDisableMonitor = mkOption {
            type = types.str;
            default = "300";
          };

          secondsToSuspend = mkOption {
            type = types.str;
            default = "900";
          };

          # CPU usage to inhibit lock in percentage
          cpuUsageThreshold = mkOption {
            type = types.str;
            default = "60";
          };

          # Disk usage to inhibit lock in MB/s
          diskUsageThreshold = mkOption {
            type = types.str;
            default = "10";
          };

          # Network usage to inhibit lock in bytes/s
          networkUsageThreshold = mkOption {
            type = types.str;
            default = "1000000";
          };
        };
      };
    };

    hardware = {
      btrfsCompression = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };

        # Use btrfs compression for mounted drives
        mounts = mkOption {
          type = types.bool;
          default = true;
        };

        # Use btrfs compression for root
        root = mkOption {
          type = types.bool;
          default = true;
        };
      };

      cpu = {
        amd = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          undervolt = {
            enable = mkOption {
              type = types.bool;
              default = true;
            };

            value = mkOption {
              type = types.str;
              # Pstate 0, 1.175 voltage, 4000 clock speed
              default = "-p 0 -v 3C -f A0";
            };
          };
        };

        intel.enable = mkOption {
          type = types.bool;
          default = false;
        };
      };

      gpu = {
        amd = mkOption {
          type = types.bool;
          default = false;
        };

        nvidia = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          powerLimit = {
            enable = mkOption {
              type = types.bool;
              default = true;
            };

            # RTX 3070
            value = mkOption {
              type = types.str;
              default = "242";
            };
          };
        };
      };

      laptop = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };

        autoCpuFreq = mkOption {
          type = types.bool;
          default = true;
        };
      };

      monitors = {
        main = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          name = mkOption {
            type = types.str;
            default = "HDMI-A-1";
          };

          resolution = mkOption {
            type = types.str;
            default = "3840x2160";
          };

          refreshRate = mkOption {
            type = types.str;
            default = "60";
          };

          position = mkOption {
            type = types.str;
            default = "1920x0";
          };

          scaling = mkOption {
            type = types.str;
            default = "1.5";
          };

          rotation = mkOption {
            type = types.str;
            default = "0";
          };
        };

        secondary = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          name = mkOption {
            type = types.str;
            default = "DP-1";
          };

          resolution = mkOption {
            type = types.str;
            default = "1920x1080";
          };

          refreshRate = mkOption {
            type = types.str;
            default = "60";
          };

          position = mkOption {
            type = types.str;
            default = "0x0";
          };

          scaling = mkOption {
            type = types.str;
            default = "1";
          };

          rotation = mkOption {
            type = types.str;
            default = "0";
          };
        };
      };

      networking = {
        hostname = mkOption {
          type = types.str;
          default = "desktop";
        };

        hosts.enable = mkOption {
          type = types.bool;
          default = false;
        };

        ipv6 = mkOption {
          type = types.bool;
          default = false;
        };
      };

      # Set to false if hardware/mounts.nix is not correctly configured
      mounts = mkOption {
        type = types.bool;
        default = true;
      };

      virtualisation = {
        # Container manager
        docker = mkOption {
          type = types.bool;
          default = true;
        };

        # A daemon that manages virtual machines
        libvirtd = mkOption {
          type = types.bool;
          default = true;
        };

        # Container daemon
        lxd = mkOption {
          type = types.bool;
          default = true;
        };

        # Passthrough USB devices to vms
        spiceUSBRedirection = mkOption {
          type = types.bool;
          default = true;
        };

        # Android container
        waydroid = mkOption {
          type = types.bool;
          default = true;
        };
      };

      # use self-built version of xpadneo to fix some controller issues
      xpadneoUnstable = mkOption {
        type = types.bool;
        default = true;
      };
    };

    system = {
      gc = {
        # Number of days before a generation can be deleted
        days = mkOption {
          type = types.str;
          default = "7";
        };

        # Number of generations that will always be kept
        generations = mkOption {
          type = types.str;
          default = "5";
        };
      };

      home = mkOption {
        type = types.str;
        default = "/home";
      };

      swappiness = mkOption {
        type = types.str;
        default = "1";
      };

      update.stashFlakeLock = mkOption {
        type = types.bool;
        default = true;
      };

      user = {
        main = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          username = mkOption {
            type = types.str;
            default = "orfous";
          };

          description = mkOption {
            type = types.str;
            default = "Orfous";
          };

          git = {
            username = mkOption {
              type = types.str;
              default = "Orfous";
            };

            email = mkOption {
              type = types.str;
              default = "orfous29@gmail.com";
            };
          };
        };

        work = {
          enable = mkOption {
            type = types.bool;
            default = false;
          };

          username = mkOption {
            type = types.str;
            default = "work";
          };

          description = mkOption {
            type = types.str;
            default = "Work";
          };

          git = {
            username = mkOption {
              type = types.str;
              default = "IceDBorn";
            };

            email = mkOption {
              type = types.str;
              default = "git.outsider841@simplelogin.fr";
            };
          };
        };
      };

      # Do not change without checking the docs (config.system.stateVersion)
      version = mkOption {
        type = types.str;
        default = "23.11";
      };
    };
  };
}
