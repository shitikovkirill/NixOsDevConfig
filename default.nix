{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.devServerConfig;
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/refs/heads/release-25.11.tar.gz";
  #gitConfig = import ./git;
  #hConfig = import ./h;
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

  config = mkIf (cfg.enable) ({
    include = [ (import "${home-manager}/nixos") ];

    home-manager.users.${cfg.user}.home.stateVersion = "25.11";
  } 
  /*// gitConfig {
    pkgs = pkgs;
    user = cfg.user;
  } // hConfig {
    pkgs = pkgs;
    codePath = cfg.codePath;
  }*/);
}
