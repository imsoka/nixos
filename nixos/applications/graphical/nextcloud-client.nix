{ pkgs, config, lib, ... }:
{
  options = {
    nextcloud-client.enable = 
      lib.mkEnableOption "enables nextcloud client";
  };

  config = lib.mkIf config.nextcloud-client.enable {
    environment.systemPackages = with pkgs; [
      nextcloud-client
    ];
  };
}
