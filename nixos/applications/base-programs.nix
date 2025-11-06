{ pkgs, lib, config, ... }:

{
  options = {
    base-programs.enable = lib.mkEnableOption "enables base programs";
  };

  config = lib.mkIf config.base-programs.enable {
    programs.git.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ 
        thunar-archive-plugin  
        thunar-volman  
        thunar-vcs-plugin 
        thunar-media-tags-plugin 
      ];
    };

    environment.systemPackages = with pkgs; [
      home-manager
      ranger
      zip
      unzip
      brave
      nextcloud-client
      keepassxc
      logseq
      alacritty
      calibre
      pavucontrol
      flameshot
      tmux
      anki
      mpv
    ];
  };
}

