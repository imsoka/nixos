{ pkgs, lib, config, ... }:
{
  options = {
    neovim = {
      enable = lib.mkEnableOption "enables nvim";
    };
  };

  config = lib.mkIf config.neovim.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];
    
  };
}
