{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.sesinetd;
in {
  options.services.sesinetd = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        start sesinetd service - SideFX's licensing server
      '';
    };
    licensesLocation = mkOption {
      type = types.str;
      default = "/var/lib/sesi";
      description = ''
        Where to store license files
      '';
    };
    package = mkOption {
      type = types.package;
      default = null;
      description = ''
        houdini package to take license manager from
      '';
    };
    user = mkOption {
      type = types.str;
      default = "sesinetd";
      description = ''
        user to run service as
      '';
    };
    group = mkOption {
      type = types.str;
      default = "sesinetd";
      description = ''
        group to run service as
      '';
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
    };
    users.groups.${cfg.group} = {};

    systemd.services.sesinetd = {
      description = "SideFX License Server";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = (import ./default_hardening.nix) // {
        IPAddressAllow = "any";
        RestrictAddressFamilies = "";
        RestrictNamespaces = false;
        ProcSubset = "all";
        SystemCallFilter = [];
        SystemCallArchitectures = "";
        StateDirectory = "sesi";
        ReadWritePaths = [ cfg.licensesLocation ];
        User = cfg.user;
        Group = cfg.group;
      };
      script = ''
        exec ${cfg.package}/bin/${cfg.package.pname} "${cfg.licensesLocation}" --user "${cfg.user}" --group "${cfg.group}" -D
      '';
    };
  };
}
