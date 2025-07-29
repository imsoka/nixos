{ config, lib, pkgs, ... }:

{
  options = {
    calibre.enable = lib.mkEnableOption "enables calibre";
  };

  config = lib.mkIf config.calibre.enable {
    environment.systemPackages = with pkgs; [
      calibre
    ];
  };
}

