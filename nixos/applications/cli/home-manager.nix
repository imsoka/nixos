{ pkgs, lib, config, ... }:
{
  options = {
    home-manager = {
      enable = lib.mkEnableOption "enables home-manager";
    };
  };

  config = lib.mkIf config.home-manager.enable {
    environment.systemPackages = with pkgs; [
      home-manager
    ];
  };
}
