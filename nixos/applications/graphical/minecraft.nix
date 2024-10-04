{ config, lib, pkgs, ... }:

{
  options = {
    minecraft.enable = lib.mkEnableOption "enables minecraft";
  };

  config = lib.mkIf config.minecraft.enable {
    environment.systemPackages = with pkgs; [
      minecraft
    ]; 
  };
}

