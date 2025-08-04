{ config, lib, pkgs, ... }:

{
  options = {
    whisparr.enable = lib.mkEnableOption "enables whisparr";
  };

  config = lib.mkIf config.whisparr.enable {
    environment.systemPackages = with pkgs; [
      whisparr
    ];
  };
}
