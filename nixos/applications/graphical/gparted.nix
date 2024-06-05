{ pkgs, config, lib, ... }:
{
  options = {
    gparted.enable =
      lib.mkEnableOption "enables gparted";
  };
  
  config = lib.mkIf config.gparted.enable {
    environment.systemPackages = with pkgs; [
      gparted
    ];
  };
}

