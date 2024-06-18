{ config, lib, pkgs, ... }:

{
  options = {
    enable = lib.mkEnableOption "enables logseq";
  };

  config = lib.mkIf config.logseq.enable {
    environment.systemPackages = with pkgs; [
      logseq
    ];
  };
}
