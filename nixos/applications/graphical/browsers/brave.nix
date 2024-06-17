{ config, lib, pkgs, ... }:

{
  options = {
    brave.enable = lib.mkEnableOption "enables brave";
  };

  config = lib.mkIf config.brave.enable {
    environment.systemPackages = with pkgs; [
      brave
    ];
  };
}
