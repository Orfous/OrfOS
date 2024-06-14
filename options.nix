{ lib, ... }:

let
  users = {
    main = {
      username = "orfous";
      description = "Orfous";
    };

    work = {
      username = "work";
      description = "Work";
    };
  };
in {
  options = with lib; {
    icedos = {
      applications = {
        android-tools = mkOption {
          type = types.bool;
          default = true;
        };

        brave = mkOption {
          type = types.bool;
          default = true;
        };

        codium = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          extensions = mkOption {
            type = types.str;
            default = ''
              "codezombiech.gitignore"
              "dbaeumer.vscode-eslint"
              "donjayamanne.githistory"
              "eamodio.gitlens"
              "editorconfig.editorconfig"
              "esbenp.prettier-vscode"
              "formulahendry.auto-close-tag"
              "formulahendry.code-runner"
              "gruntfuggly.todo-tree"
              "jnoortheen.nix-ide"
              "markwylde.vscode-filesize"
              "mblode.twig-language-2"
              "ms-vscode.references-view"
              "nico-castell.linux-desktop-file"
              "paragdiwan.gitpatch"
              "pkief.material-icon-theme"
              "timonwong.shellcheck"
              "zhuangtongfa.material-theme"
              "ziyasal.vscode-open-in-github"
            '';
          };

          zoomLevel = mkOption {
            type = types.str;
            default = "0";
          };
        };

        firefox = {
          enable = mkOption {
            type = types.bool;
            default = true;
          };

          overrides = mkOption {
            type = types.bool;
            default = true;
          };

          privacy = mkOption {
            type = types.bool;
            default = false;
          };

          # Sites to launch on Firefox PWAs
          pwas = mkOption {
            type = types.str;
            default = "https://develop.element.io https://discord.com/app";
          };
        };

        # Hide kitty top bar
        kitty.hideDecorations = mkOption {
          type = types.bool;
          default = true;
        };

        nvchad = mkOption {
          type = types.bool;
          default = true;
        };

        steam = {
          beta = mkOption {
            type = types.bool;
            default = false;
          };

          # Workaround for slow steam downloads
          downloadsWorkaround = mkOption {
            type = types.bool;
            default = true;
          };

          session = {
            enable = mkOption {
              type = types.bool;
              default = false;
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
          };
        };

        sunshine.enable = mkOption {
          type = types.bool;
          default = false;
        };

        emulators.switch = mkOption {
          type = types.bool;
          default = false;
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

          mountPoint = mkOption {
            type = types.str;
            default = "/boot";
          };
        };
      };

      desktop = {
        autologin = {
          enable = mkOption {
            type = types.bool;
            default = false;
          };

          user = mkOption {
            type = types.str;
            default = users.main.username;
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

          extensions = {
            arcmenu = mkOption {
              type = types.bool;
              default = false;
            };

            dashToPanel = mkOption {
              type = types.bool;
              default = false;
            };

            gsconnect = mkOption {
              type = types.bool;
              default = true;
            };
          };

          # Show the month and day of the month on the clock
          clock = {
            date = mkOption {
              type = types.bool;
              default = false;
            };

            # Show the day of the week on the clock
            weekday = mkOption {
              type = types.bool;
              default = false;
            };
          };

          hotCorners = mkOption {
            type = types.bool;
            default = true;
          };

          powerButtonAction = mkOption {
            type = types.str;
            default = "interactive";
          };

          startupItems = mkOption {
            type = types.bool;
            default = true;
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

        hyprland = {
          enable = mkOption {
            type = types.bool;
            default = false;
          };

          # Find backlight unit using brightnessctl
          backlight = mkOption {
            type = types.str;
            default = "amdgpu_bl0";
          };

          lock = {
            secondsToLowerBrightness = mkOption {
              type = types.str;
              default = "60";
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

						beta = mkOption {
							type = types.bool;
							default = false;
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

        laptop = mkOption {
          type = types.bool;
          default = false;
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

          second = {
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

        steamdeck = mkOption {
          type = types.bool;
          default = false;
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
      };

      system = {
        config.version = mkOption {
          type = types.str;
          default = "1.0.0";
        };

        generations = {
          bootEntries = mkOption {
            type = types.number;
            default = 10;
          };

          garbageCollect = {
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
        };

        home = mkOption {
          type = types.str;
          default = "/home";
        };

        swappiness = mkOption {
          type = types.str;
          default = "1";
        };

        user = {
          main = {
            enable = mkOption {
              type = types.bool;
              default = true;
            };

            username = mkOption {
              type = types.str;
              default = users.main.username;
            };

            description = mkOption {
              type = types.str;
              default = users.main.description;
            };

            applications = {
              codium = {
                # off, afterDelay, onFocusChange, onWindowChange
                autoSave = mkOption {
                  type = types.str;
                  default = "onFocusChange";
                };

                formatOnSave = mkOption {
                  type = types.str;
                  default = "true";
                };

                formatOnPaste = mkOption {
                  type = types.str;
                  default = "false";
                };
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

              nvchad.formatOnSave = mkOption {
                type = types.bool;
                default = true;
              };
            };

            desktop = {
              gnome.pinnedApps = {
                arcmenu = {
                  enable = mkOption {
                    type = types.bool;
                    default = false;
                  };

                  list = mkOption {
                    type = with types; listOf str;
                    default = [
                      "Codium IDE"
                      ""
                      "codiumIDE.desktop"
                      "VSCodium"
                      ""
                      "codium.desktop"
                      "Spotify"
                      ""
                      "spotify.desktop"
                      "Mullvad VPN"
                      ""
                      "mullvad-vpn.desktop"
                      "GNU Image Manipulation Program"
                      ""
                      "gimp.desktop"
                    ];
                  };
                };

                # Set pinned apps for gnome shell (will be used by dash-to-panel if enabled)
                shell = {
                  enable = mkOption {
                    type = types.bool;
                    default = false;
                  };

                  list = mkOption {
                    type = with types; listOf str;
                    default = [
                      "steam.desktop"
                      "webcord.desktop"
                      "signal-desktop.desktop"
                      "firefox.desktop"
                    ];
                  };
                };
              };

              idle = {
                lock = {
                  enable = mkOption {
                    type = types.bool;
                    default = true;
                  };

                  seconds = mkOption {
                    type = types.str;
                    default = "300";
                  };
                };

                disableMonitors = {
                  enable = mkOption {
                    type = types.bool;
                    default = true;
                  };

                  seconds = mkOption {
                    type = types.str;
                    default = "180";
                  };
                };

                suspend = {
                  enable = mkOption {
                    type = types.bool;
                    default = false;
                  };

                  seconds = mkOption {
                    type = types.str;
                    default = "900";
                  };
                };
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
              default = users.work.username;
            };

            description = mkOption {
              type = types.str;
              default = users.work.description;
            };

            applications = {
              codium = {
                # off, afterDelay, onFocusChange, onWindowChange
                autoSave = mkOption {
                  type = types.str;
                  default = "off";
                };

                formatOnSave = mkOption {
                  type = types.str;
                  default = "false";
                };

                formatOnPaste = mkOption {
                  type = types.str;
                  default = "false";
                };
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

              nvchad.formatOnSave = mkOption {
                type = types.bool;
                default = false;
              };
            };

            desktop = {
              gnome.pinnedApps = {
                arcmenu = {
                  enable = mkOption {
                    type = types.bool;
                    default = false;
                  };

                  list = mkOption {
                    type = with types; listOf str;
                    default = [
                      "Codium IDE"
                      ""
                      "codiumIDE.desktop"
                      "VSCodium"
                      ""
                      "codium.desktop"
                      "Spotify"
                      ""
                      "spotify.desktop"
                      "Mullvad VPN"
                      ""
                      "mullvad-vpn.desktop"
                      "GNU Image Manipulation Program"
                      ""
                      "gimp.desktop"
                    ];
                  };
                };

                # Set pinned apps for gnome shell (will be used by dash-to-panel if enabled)
                shell = {
                  enable = mkOption {
                    type = types.bool;
                    default = false;
                  };

                  list = mkOption {
                    type = with types; listOf str;
                    default = [
                      "slack.desktop"
                      "webcord.desktop"
                      "signal-desktop.desktop"
                      "firefox.desktop"
                      "webstorm.desktop"
                    ];
                  };
                };
              };

              idle = {
                lock = {
                  enable = mkOption {
                    type = types.bool;
                    default = true;
                  };

                  seconds = mkOption {
                    type = types.str;
                    default = "180";
                  };
                };

                disableMonitors = {
                  enable = mkOption {
                    type = types.bool;
                    default = true;
                  };

                  seconds = mkOption {
                    type = types.str;
                    default = "300";
                  };
                };

                suspend = {
                  enable = mkOption {
                    type = types.bool;
                    default = true;
                  };

                  seconds = mkOption {
                    type = types.str;
                    default = "900";
                  };
                };
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
  };
}
