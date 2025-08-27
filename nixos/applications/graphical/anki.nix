{ config, lib, pkgs, ... }:

{
  options = {
    anki.enable = lib.mkEnableOption "enables anki";
  };

  config = lib.mkIf config.anki.enable {
    environment.systemPackages = with pkgs; [
      anki
    ]; 
  };
}

