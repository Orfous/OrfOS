{ config, lib, ... }:

let
  mapAttrsAndKeys = callback: list:
    (lib.foldl' (acc: value: acc // (callback value)) { } list);
in {
  home-manager.users = let
    users = lib.filter (user: config.system.user.${user}.enable == true)
      (lib.attrNames config.system.user);
  in mapAttrsAndKeys (user:
    let username = config.system.user.${user}.username;
    in {
      ${username} = lib.mkIf config.desktop.hyprland.enable {
        home.file = {
          # Add wlogout config files
          ".config/wlogout" = {
            source = configs/wlogout;
            recursive = true;
          };

          # Add hyprpaper config files
          ".config/hypr/hyprpaper.conf".text = ''
            preload = ~/.config/hypr/hyprpaper.jpg
            wallpaper = , ~/.config/hypr/hyprpaper.jpg
            ipc = off
          '';

          ".config/hypr/hyprpaper.jpg".source = configs/hyprpaper.jpg;
        };
      };
    }) users;
}