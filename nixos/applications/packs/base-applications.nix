{ config, lib, pkgs, ... }:

{
  imports = [
    ../applications/cli/home-manager.nix
    ../applications/cli/neovim.nix
    ../applications/cli/git.nix
    ../applications/cli/vim.nix

    ../applications/graphical/keepassxc.nix
    ../applications/graphical/nextcloud-client.nix
    ../applications/graphical/logseq.nix
    ../applications/graphical/alacritty.nix
    ../applications/graphical/browsers/brave.nix
  ]
  options = {
    base-applications.enable = lib.mkEnableOption "enables base applications"
  }

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
  }
};
