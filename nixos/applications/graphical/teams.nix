{ config, lib, pkgs, ... }:

{
  options = {
    teams.enable = lib.mkEnableOption "enables teams";
  };

  config = lib.mkIf config.teams.enable {
    environment.systemPackages = with pkgs; [
      teams
    ]; 
  };
}


