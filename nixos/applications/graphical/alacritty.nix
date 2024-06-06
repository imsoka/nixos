{ config, lib, pkgs, ... }:

{
  options = {
    alacritty.enable = lib.mkEnableOption "enables alacritty";
  };

  config = lib.mkIf config.alacritty.enable {
    environment.systemPackages = with pkgs; [
      alacritty
    ]; 
  };
}
