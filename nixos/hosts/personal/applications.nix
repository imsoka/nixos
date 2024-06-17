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
      ../../applications/graphical/qflipper.nix
      ../../applications/graphical/steam.nix
      ../../applications/graphical/webcord.nix
      ../../applications/graphical/gparted.nix
      ../../applications/graphical/alacritty.nix
      ../../applications/graphical/libreoffice.nix
      ../../applications/graphical/browsers/firefox.nix
    ];

  nixpkgs.config.allowUnfree = true;

  git.enable = true;
  firefox.enable = true;
  neovim.enable = true;
  vim.enable = true;
  home-manager.enable = true;
  nextcloud-client.enable = true;
  keepassxc.enable = true;
  lutris.enable = true;
  steam.enable = true;
  webcord.enable = true;
  gparted.enable = true;
  alacritty.enable = true;
  libreoffice.enable = true;
  qflipper.enable = true;
}
