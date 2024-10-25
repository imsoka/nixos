{ config, lib, pkgs, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "enables thunar";
  };

  config = lib.mkIf config.thunar.enable {
    environment.systemPackages = with pkgs; [
      xfce.thunar
    ]; 
  };
}

