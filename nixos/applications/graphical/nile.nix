{ config, lib, pkgs, ... }:

{
  options = {
    nile.enable = lib.mkEnableOption "enables nile";
  };

  config = lib.mkIf config.nile.enable {
    environment.systemPackages = with pkgs; [
      nile
    ]; 
  };
}
