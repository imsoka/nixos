{ pkgs, lib, config, ... }:
{
  options = {
    tmux = {
      enable = lib.mkEnableOption "enables tmux";
    };
  };

  config = lib.mkIf config.tmux.enable {
    environment.systemPackages = with pkgs; [
      tmux
    ];
  };
}


