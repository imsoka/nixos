{ config, lib, pkgs, ... }:

{
  options = {
    flameshot.enable = lib.mkEnableOption "enables flameshot";
  };

  config = lib.mkIf config.flameshot.enable {
    environment.systemPackages = with pkgs; [
      flameshot
    ]; 
  };
}


