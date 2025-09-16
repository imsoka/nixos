{ pkgs, lib, config, ... }:

{
  options = {
    gaming-programs.enable = lib.mkEnableOption "enables gaming programs";
  };


  config = lib.mkIf config.gaming-programs.enable {
    environment.systemPackages = with pkgs; [
      wine
      lutris
      mangohud
      webcord
    ];

    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

    environment.variables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
        "/games/compatibilitytools/";
    };
  };
}

