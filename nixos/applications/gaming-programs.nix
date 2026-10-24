{ pkgs, lib, config, ... }:

let
  a2tools = pkgs.callPackage ./a2tools-dps-meter/package.nix { };
in
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
      # DPI y botones del ratón (G305) en su memoria interna, vía ratbagd
      piper
      # DPS meter de AION 2; se abre a mano
      a2tools
    ];

    # Macros y remapeo de teclado y ratón (GUI "Input Remapper"). Va por
    # evdev/uinput, así que funciona en Wayland, niri y gamescope
    services.input-remapper.enable = true;
    # La GUI arranca su lector de dispositivos con pkexec: sin pedir
    # contraseña cada vez, solo ese comando, solo para wheel en la sesión
    # local activa; el grupo input ya puede leer los dispositivos igualmente.
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.policykit.exec" &&
            action.lookup("program") ==
              "${config.services.input-remapper.package}/bin/input-remapper-control" &&
            subject.isInGroup("wheel") && subject.local && subject.active) {
          return polkit.Result.YES;
        }
      });
    '';
    services.ratbagd.enable = true;

    # El meter captura el tráfico del juego: necesita cap_net_raw, nunca root
    security.wrappers.a2tools-dps-meter = {
      source = "${a2tools}/bin/a2tools-dps-meter";
      owner = "root";
      group = "root";
      capabilities = "cap_net_raw+ep";
    };

    programs.steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        # gamescope no hereda el layout de niri, usa XKB (por defecto "us")
        env.XKB_DEFAULT_LAYOUT = "es";
      };
      protontricks.enable = true;
      # Steam Input con juegos X11 bajo Wayland
      extest.enable = true;
    };

    programs.gamescope = {
      enable = true;
      env.XKB_DEFAULT_LAYOUT = "es";
    };

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

