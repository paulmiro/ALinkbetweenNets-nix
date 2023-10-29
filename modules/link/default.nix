{ lib, pkgs, config, nixpkgs, flake-self, home-manager, ... }: with lib;
{
  options.link = {
    domain = mkOption {
      type = types.str;
      default = "alinkbetweennets.de";
      description = "Main Domain name for all services";
    };
    storage = mkOption {
      type = types.str;
      default = "/var/lib";
      description = "storage path for all services";
    };
    secrets = mkOption {
      type = types.str;
      default = "/pwd";
      description = "storage path for all secrets";
    };
  };
}
