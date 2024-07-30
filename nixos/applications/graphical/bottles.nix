{ pkgs, config, lib, ... }:

{
  options = {
    bottles.enable = 
      lib.mkEnableOption "enables bottles";
  };

  config = lib.mkIf config.bottles.enable {
    environment.systemPackages = with pkgs; [
      bottles
    ];
  };
}
