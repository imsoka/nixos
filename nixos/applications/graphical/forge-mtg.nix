{ config, lib, pkgs, ... }:

{
  options = {
    forge-mtg.enable = lib.mkEnableOption "enables forge-mtg";
  };

  config = lib.mkIf config.forge-mtg.enable {
    environment.systemPackages = with pkgs; [
      forge-mtg
    ]; 
  };
}


