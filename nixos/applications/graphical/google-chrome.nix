{ config, lib, pkgs, ... }:

{
  options = {
    google-chrome.enable = lib.mkEnableOption "enables google-chrome";
  };

  config = lib.mkIf config.google-chrome.enable {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];
  };
}

