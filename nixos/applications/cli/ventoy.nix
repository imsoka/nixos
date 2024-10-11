{ pkgs, lib, config, ... }:
{
  options = {
    ventoy-full = {
      enable = lib.mkEnableOption "enables ventoy-full";
    };
  };

  config = lib.mkIf config.ventoy-full.enable {
    environment.systemPackages = with pkgs; [
      ventoy-full
    ];
  };
}

