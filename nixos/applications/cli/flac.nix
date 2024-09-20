{ pkgs, lib, config, ... }:
{
  options = {
    flac = {
      enable = lib.mkEnableOption "enables flac";
    };
  };

  config = lib.mkIf config.home-manager.enable {
    environment.systemPackages = with pkgs; [
      flac
    ];
  };
}

