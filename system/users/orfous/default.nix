{
  pkgs,
  ...
}:

let
  launchers = with pkgs; [
    # cemu
    # duckstation
    heroic
    # pcsx2
    # ppsspp
    # prismlauncher
    # rpcs3
  ];
in
{
  users.users.orfous.packages =
    with pkgs;
    [
      appimage-run
      blanket
      bottles
      fragments
      gimp
      harmony-music
      newsflash
      warp
    ]
    ++ launchers;
}
