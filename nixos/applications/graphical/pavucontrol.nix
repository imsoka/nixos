{ config, lib, pkgs, ... }:

{
  options = {
    pavucontrol.enable = lib.mkEnableOption "enables pavucontrol";
  };

  config = lib.mkIf config.pavucontrol.enable {
    environment.systemPackages = with pkgs; [
      pavucontrol
    ]; 
  };
}

