{ lib, config, ... }:

{
  imports = [
    ./cli/home-manager.nix
    ./cli/git.nix
    ./cli/vim.nix
    ./cli/ranger.nix
    ./cli/unzip.nix

    ./graphical/keepassxc.nix
    ./graphical/nextcloud-client.nix
    ./graphical/alacritty.nix
    ./graphical/browsers/brave.nix
    ./graphical/logseq.nix
    ./graphical/libreoffice.nix
    ./graphical/calibre.nix
  ];

  options = {
    base-programs.enable = lib.mkEnableOption "enables base programs";
  };

  config = lib.mkIf config.base-programs.enable {
    git.enable = true;
    vim.enable = true;
    home-manager.enable = true;
    ranger.enable = true;
    libreoffice.enable = true;
    brave.enable = true;
    nextcloud-client.enable = true;
    keepassxc.enable = true;
    logseq.enable = true;
    alacritty.enable = true;
    calibre.enable = true;
  };
}

