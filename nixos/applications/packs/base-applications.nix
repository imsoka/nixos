{ config, lib, pkgs, ... }:

{
  imports = [
    ../cli/home-manager.nix
    ../cli/neovim.nix
    ../cli/git.nix
    ../cli/vim.nix

    ../graphical/keepassxc.nix
    ../graphical/nextcloud-client.nix
    ../graphical/logseq.nix
    ../graphical/alacritty.nix
    ../graphical/browsers/brave.nix
  ];

  options = {
    base-applications.enable = lib.mkEnableOption "enables base applications";
  };

  config = lib.mkIf config.base-applications.enable {
    git.enable = true;
    neovim.enable = true;
    vim.enable = true;
    home-manager.enable = true;

    brave.enable = true;
    nextcloud-client.enable = true;
    keepassxc.enable = true;
    logseq.enable = true;
    alacritty.enable = true;
  };
}
