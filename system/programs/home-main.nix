{ config, pkgs, lib, ... }:

lib.mkIf config.main.user.enable {
	home-manager.users.${config.main.user.username} = {
		programs = {
			git = {
				enable = true;
				# Git config
				userName  = "${config.main.user.github.username}";
				userEmail = "${config.main.user.github.email}";
			};

			kitty = {
				enable = true;
				settings = {
					background_opacity = "0.8";
					confirm_os_window_close = "0";
					cursor_shape = "underline";
					cursor_underline_thickness = "1.0";
					enable_audio_bell = "no";
					hide_window_decorations = "yes";
					update_check_interval = "0";
				};
				font.name = "Jetbrains Mono";
			};

			mangohud = {
				enable = true;
				# Mangohud config
				settings = {
					background_alpha = 0;
					cpu_color = "FFFFFF";
					cpu_temp = true;
					engine_color = "FFFFFF";
					font_size = 20;
					fps = true;
					fps_limit = "144+60+0";
					frame_timing = 0;
					gamemode = true;
					gl_vsync = 0;
					gpu_color = "FFFFFF";
					gpu_temp = true;
					no_small_font = true;
					offset_x = 50;
					position = "top-right";
					toggle_fps_limit = "F1";
					vsync= 1;
				};
			};

			zsh = {
				enable = true;
				# Enable firefox wayland
				profileExtra = "export MOZ_ENABLE_WAYLAND=1";

				# Install powerlevel10k
				plugins = with pkgs; [
					{
						name = "powerlevel10k";
						src = pkgs.zsh-powerlevel10k;
						file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
					}
					{
						name = "zsh-nix-shell";
						file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
						src = pkgs.zsh-nix-shell;
					}
				];

				initExtra = ''eval "$(direnv hook zsh)"'';
			};

			# Install gnome extensions using firefox
			firefox.enableGnomeExtensions = true;
		};

		home.file = {
			# Add zsh theme to zsh directory
			".config/zsh/zsh-theme.zsh" = {
				source = ../configs/zsh-theme.zsh;
				recursive = true;
			};

			# Add proton-ge-updater script to zsh directory
			".config/zsh/proton-ge-updater.sh" = {
				source = ../scripts/proton-ge-updater.sh;
				recursive = true;
			};

			# Add arkenfox user.js
			".mozilla/firefox/privacy/user.js" = lib.mkIf config.firefox-privacy.enable {
				source =
				"${(config.nur.repos.slaier.arkenfox-userjs.overrideAttrs (oldAttrs: {
					installPhase = ''
						cat ${../configs/firefox-user-overrides.js} >> user.js
						mkdir -p $out
						cp ./user.js $out/user.js
					'';
				}))}/user.js";
				recursive = true;
			};

			# Set firefox to privacy profile
			".mozilla/firefox/profiles.ini" = lib.mkIf config.firefox-privacy.enable {
				source = ../configs/firefox-profiles.ini;
				recursive = true;
			};

			# Add noise suppression microphone
			".config/pipewire/pipewire.conf.d/99-input-denoising.conf" = {
				source = ../configs/pipewire.conf;
				recursive = true;
			};

			# Add btop config
			".config/btop/btop.conf" = {
				source = ../configs/btop.conf;
				recursive = true;
			};

			# Add kitty session config
			".config/kitty/kitty.session" = {
				source = ../configs/kitty.session;
				recursive = true;
			};

			# Add kitty task managers session config
			".config/kitty/kitty-task-managers.session" = {
				source = ../configs/kitty-task-managers.session;
				recursive = true;
			};

			# Add adwaita steam skin
			".local/share/Steam/skins/Adwaita" = {
				source = "${(pkgs.callPackage ../programs/self-built/adwaita-for-steam {})}/build/Adwaita";
				recursive = true;
			};

			# Enable steam beta
			".local/share/Steam/package/beta" = lib.mkIf config.steam.beta.enable {
				text = "publicbeta";
				recursive = true;
			};
		};
	};
}