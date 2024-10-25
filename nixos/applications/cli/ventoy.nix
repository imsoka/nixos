{ pkgs, lib, config, ... }:
{
  options = {
    ventoy = {
      enable = lib.mkEnableOption "enables ventoy";
    };
  };

  config = lib.mkIf config.ventoy.enable {
    environment.systemPackages = with pkgs; [
      ventoy-full
    ];
  };
}

