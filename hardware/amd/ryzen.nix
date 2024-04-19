{ pkgs, lib, config, ... }:

let
  inherit (lib) mkIf;

  cfg = config.icedos.hardware.cpu.amd;
in mkIf (cfg.enable) {
  boot = {
    kernelModules = [ "msr" "zenpower" ];
    extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  };

  hardware.cpu.amd.updateMicrocode = true;

  # Ryzen cpu control
  systemd.services.zenstates = mkIf (cfg.undervolt.enable) {
    enable = true;
    description = "Ryzen Undervolt";
    after = [ "syslog.target" "systemd-modules-load.service" ];

    unitConfig = { ConditionPathExists = "${pkgs.zenstates}/bin/zenstates"; };

    serviceConfig = {
      User = "root";
      ExecStart = "${pkgs.zenstates}/bin/zenstates ${cfg.undervolt.value}";
    };

    wantedBy = [ "multi-user.target" ];
  };
  systemd.services.autoOwn = {
    enable = true;
    description = "Ryzen Undervolt";
    after = [ "syslog.target" "systemd-modules-load.service" ];
    serviceConfig = {
      User = "root";
      ExecStart =
        "/run/current-system/sw/bin/chown -R orfous:users '/mnt/Harder Drive'";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
