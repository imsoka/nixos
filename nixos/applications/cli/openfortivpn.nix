{ pkgs, lib, config, ... }:
{
  options = {
    openfortivpn = {
      enable = lib.mkEnableOption "enables openfortivpn";
    };
  };

  config = lib.mkIf config.git.enable {
    programs.openfortivpn.enable = true;
  };
}

