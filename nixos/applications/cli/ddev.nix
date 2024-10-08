{ pkgs, lib, config, ... }:
{
  options = {
    ddev = {
      enable = lib.mkEnableOption "enables ddev";
    };
  };

  config = lib.mkIf config.ddev.enable {
    environment.systemPackages = with pkgs; [
      curl
      mkcert
      docker-compose
      ddev
    ];
  };
}
