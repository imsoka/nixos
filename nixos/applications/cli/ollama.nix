{ pkgs, lib, config, ... }:
{
  options = {
    ddev = {
      enable = lib.mkEnableOption "enables ollama";
    };
  };

  config = lib.mkIf config.ollama.enable {
    environment.systemPackages = with pkgs; [
        ollama-cuda
    ];
  };
}

