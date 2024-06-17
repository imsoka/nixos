{ pkgs, config, lib, ... }:

{
  options = {
    libreoffice.enable = lib.mkEnableOption "enables libreoffice";
  };


  config = lib.mkIf config.libreoffice.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-fresh
    ];
  };
}
