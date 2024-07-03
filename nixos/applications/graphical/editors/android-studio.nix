{ config, lib, pkgs, ... }:

{
  options = {
    android-studio.enable = lib.mkEnableOption "enables android studio"
  };

  config = lib.mkIf config.android-studio.enable {
    environment.systemPackages = with pkgs; [
      android-studio
    ];
  };
}

