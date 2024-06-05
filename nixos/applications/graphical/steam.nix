{ pkgs, config, lib, ... }:
{
  options = {
    steam.enable = 
      lib.mkEnableOption "installs steam";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
    ];

   environment.variables = {
     STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
       "/games/compatibilitytools/";
   };
  };
}

