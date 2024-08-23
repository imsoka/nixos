{ config, lib, pkgs, ... }:

{
  options = {
    mpv.enable = lib.mkEnableOption "enables mpv";
  };

  config = lib.mkIf config.mpv.enable {
    environment.systemPackages = with pkgs; [
      mpv
    ]; 
  };
}
