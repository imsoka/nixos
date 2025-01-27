{ pkgs, lib, config, ... }:
{
  options = {
    ddev = {
      enable = lib.mkEnableOption "enables openfortivpn";
    };
  };

  config = lib.mkIf config.openfortivpn.enable {
    environment.systemPackages = with pkgs; [
      openfortivpn
    ];
  };
}

