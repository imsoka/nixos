{ config, lib, pkgs, ... }:

{
  options = {
    dbeaver.enable = lib.mkEnableOption "enables dbeaver";
  };

  config = lib.mkIf config.dbeaver.enable {
    environment.systemPackages = with pkgs; [
      dbeaver-bin
    ]; 
  };
}

