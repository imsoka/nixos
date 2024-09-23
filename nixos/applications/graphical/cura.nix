{ pkgs, config, lib, ... }:
{
  options = {
    cura.enable =
      lib.mkEnableOption "enables cura";
  };
  
  config = lib.mkIf config.cura.enable {
    environment.systemPackages = with pkgs; [
      cura
    ];
  };
}

