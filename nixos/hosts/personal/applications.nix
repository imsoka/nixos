{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../../applications/cli/neovim.nix
      ../../applications/cli/vim.nix
      ../../applications/cli/home-manager.nix
      ../../applications/cli/git.nix
      ../../applications/graphical/nextcloud-client.nix
      ../../applications/graphical/keepassxc.nix
      ../../applications/graphical/lutris.nix
      ../../applications/graphical/steam.nix
      ../../applications/graphical/webcord.nix
      ../../applications/graphical/gparted.nix
      ../../applications/graphical/browsers/firefox.nix
    ];

  config.nixpkgs.config.allowUnfree = true;

  config.git.enable = true;
  config.firefox.enable = true;
  config.neovim.enable = true;
  config.vim.enable = true;
  config.home-manager.enable = true;
  config.nextcloud-client.enable = true;
  config.keepassxc.enable = true;
  config.lutris.enable = true;
  config.steam.enable = true;
  config.webcord.enable = true;
  config.gparted.enable = true;
}
