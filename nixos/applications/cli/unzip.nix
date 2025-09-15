{ pkgs, lib, config, ... }:
{
  options = {
    unzip = {
      enable = lib.mkEnableOption "enables unzip";
    };
  };

  config = lib.mkIf config.unzip.enable {
    environment.systemPackages = with pkgs; [
      unzip
    ];
  };
}


