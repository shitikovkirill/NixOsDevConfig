{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.devServerConfig;
  user = cfg.user;
  codePath = cfg.codePath;
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
      user = mkOption {
        default = "nixos";
        type = types.str;
        description = "The default username for your system.";
        example = "exampleUser";
      };
      codePath = mkOption {
        default = "~/Development";
        type = types.str;
        description = "The default username for your system.";
        example = "~/Development";
      };
    };
  };

  imports = [ ./git ./h ./aliases.nix ];

  config = mkIf (cfg.enable) {

  };
}
