{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.devServerConfig;
  hConfig = import ./h;
in {
  options = {
    services.devServerConfig = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable dev server.
        '';
      };
      codePath = mkOption {
        default = "~/Development";
        type = types.str;
        description = "The default username for your system.";
        example = "~/Development";
      };
    };
  };

  config = mkIf (cfg.enable) ({
    include = [ ./git ];
  } // hConfig {
    pkgs = pkgs;
    codePath = cfg.codePath;
  });
}
