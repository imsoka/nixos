{ pkgs, lib, config, ... }:

{
  options = {
    texlive = {
      enable = lib.mkEnableOption "enables TeXlive";
    };
  };

  config = lib.mkIf config.texlive.enable {
    environment.systemPackages = with pkgs; [
     texliveFull
    ];
  };
}
