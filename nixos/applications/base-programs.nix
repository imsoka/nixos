{ pkgs, lib, config, ... }:

{
  options = {
    base-programs.enable = lib.mkEnableOption "enables base programs";
  };

  config = lib.mkIf config.base-programs.enable {
    programs.git.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs; [ 
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
      alacritty
      calibre
      pavucontrol
      flameshot
      tmux
      anki
      mpv
      claude-code
    ];

    # CJK: las Noto CJK por defecto son variables (.ttc VF) y Brave/Chromium a
    # veces no las usa de respaldo; las estáticas y la preferencia explícita sí.
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans-static
      noto-fonts-cjk-serif-static
    ];
    fonts.fontconfig.defaultFonts = {
      sansSerif = [ "DejaVu Sans" "Noto Sans CJK JP" "Noto Sans CJK SC" ];
      serif = [ "DejaVu Serif" "Noto Serif CJK JP" "Noto Serif CJK SC" ];
      monospace = [ "DejaVu Sans Mono" "Noto Sans Mono CJK JP" ];
    };

    nixpkgs.config = { allowUnfree = true; };
  };
}

