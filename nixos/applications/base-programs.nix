{ pkgs, lib, config, ... }:

{
  options = {
    base-programs.enable = lib.mkEnableOption "enables base programs";
  };

  config = lib.mkIf config.base-programs.enable {
    environment.systemPackages = with pkgs; [
      home-manager
      ranger
      zip
      unzip
      brave
      nextcloud-client
      keepassxc
      logseq
      aclacritty
      calibre
      pavucontrol
      flameshot
      tmux
      thunar
      anki
      mpv
    ];

    programs.git.enable = true;

    git.enable = true;
    home-manager.enable = true;
    ranger.enable = true;
    unzip.enable = true;
    brave.enable = true;
    nextcloud-client.enable = true;
    keepassxc.enable = true;
    logseq.enable = true;
    alacritty.enable = true;
    calibre.enable = true;
    pavucontrol.enable = true;
    flameshot.enable = true;
    tmux.enable = true;
    thunar.enable = true;
  };
}

