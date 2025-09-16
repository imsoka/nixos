{ pkgs, lib, config, ... }:
{
  options = {
    codex = {
      enable = lib.mkEnableOption "enables codex";
    };
  };

  config = lib.mkIf config.codex.enable {
    environment.systemPackages = with pkgs; [
      codex
    ];
  };
}

