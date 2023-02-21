{ config, pkgs, lib, ... }:

lib.mkIf config.main.user.enable {
	home-manager.users.${config.main.user.username} = {
		gtk = {
			# Change GTK themes
			enable = true;
			theme = {
				name = "Adwaita-dark";
			};
			cursorTheme = {
				name = "Bibata-Modern-Classic";
			};
			iconTheme = {
				name = "Tela-black-dark";
			};
		};

		dconf.settings = {
			"org/gnome/nautilus/preferences" = {
				always-use-location-entry = true;
			}; # Nautilus path bar is always editable

			"org/gtk/gtk4/settings/file-chooser" = {
				sort-directories-first = true;
			}; # Nautilus sorts directories first
		};

		xdg = {
			desktopEntries = {
				discord = {
					name = "Discord";
					exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
					icon = "discord";
				}; # Force discord to use wayland

				mullvad-gui = {
					name = "Mullvad";
					exec = "mullvad-gui --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
					icon = "mullvad-vpn";
				}; # Force mullvad to use wayland and window decorations
			};

			mimeApps = {
				enable = true;

				defaultApplications = {
					"text/plain" = ["sublime_text.desktop"];
				};
			}; # Default apps
		};

		home.file = {
			"Templates/new" = {
				text = "";
				recursive = true;
			};

			"Templates/new.cfg" = {
				text = "";
				recursive = true;
			};

			"Templates/new.ini" = {
				text = "";
				recursive = true;
			};

			"Templates/new.sh" = {
				text = "";
				recursive = true;
			};

			"Templates/new.txt" = {
				text = "";
				recursive = true;
			};
		}; # New document options for nautilus
	};
}
