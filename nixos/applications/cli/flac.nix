{ pkgs, lib, config, ... }:
{
  options = {
    flac = {
      enable = lib.mkEnableOption "enables flac";
    };
  };

  config = lib.mkIf config.flac.enable {
    environment.systemPackages = with pkgs; [
      curl
      mkcert
      docker-compose
      flac
    ];
  };
}

