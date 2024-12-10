{ config, lib, pkgs, ... }:

{
  options = {
    qbittorrent.enable = lib.mkEnableOption "enables qbittorrent";
  };

  config = lib.mkIf config.qbittorrent.enable {
    environment.systemPackages = with pkgs; [
      qbittorrent
    ]; 
  };
}

