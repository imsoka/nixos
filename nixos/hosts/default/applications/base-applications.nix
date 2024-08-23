{ pkgs, lib, config, ... }:

{
  imports = [
    ../../applications/cli/home-manager.nix
    ../../applications/cli/neovim.nix
    ../../applications/cli/git.nix
    ../../applications/cli/vim.nix
    ../../applications/cli/ranger.nix

    ../../applications/graphical/keepassxc.nix
    ../../applications/graphical/nextcloud-client.nix
    ../../applications/graphical/alacritty.nix
    ../../applications/graphical/browsers/brave.nix
    ../../applications/graphical/logseq.nix
    ../../applications/graphical/libreoffice.nix
  ];

  nixpkgs.config.allowUnfree = true;

  git.enable = true;
  neovim.enable = true;
  vim.enable = true;
  home-manager.enable = true;
  ranger.enable = true;

  libreoffice.enable = true;
  brave.enable = true;
  nextcloud-client.enable = true;
  keepassxc.enable = true;
  logseq.enable = true;
  alacritty.enable = true;
}

