{ pkgs, lib, config, ... }:

{
  options = {
    gaming-programs.enable = lib.mkEnableOption "enables gaming programs";
  };


  config = lib.mkIf config.gaming-programs.enable {
    environment.systemPackages = with pkgs; [
      wine
      lutris
      # Lanzador a pantalla completa para mando
      pegasus-frontend
      mangohud
      discord
    ];

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      # Steam Input con juegos X11 bajo Wayland
      extest.enable = true;
    };

    programs.gamescope.enable = true;

    # gamemoderun %command%: renice, governor de CPU y PowerMizer de NVIDIA
    # al máximo mientras dura el juego. El usuario debe estar en "gamemode".
    programs.gamemode = {
      enable = true;
      settings = {
        general.renice = 10;
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          nv_powermizer_mode = 1;
        };
      };
    };

    # NTSYNC: sincronización nativa de Windows en el kernel, Proton/GE-Proton
    # la usan si existe /dev/ntsync (mejora el rendimiento en CPU)
    boot.kernelModules = [ "ntsync" ];
    services.udev.extraRules = ''
      KERNEL=="ntsync", MODE="0666"
    '';

    environment.variables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
        "/games/compatibilitytools/";
    };
  };
}

