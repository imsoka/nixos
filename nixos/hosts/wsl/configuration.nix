# NixOS-WSL en el portátil Windows (sustituye a sokix-work cuando el portátil pasa a Windows).
# Solo terminal: el escritorio lo pone Windows (GlazeWM + Zebar, ver windows/ en home-manager).
# Instalación y primer arranque: ver CLAUDE.md de este repo.
{ pkgs, ... }:

{
  imports = [
    ../../locales/es.nix
  ];

  wsl = {
    enable = true;
    # Crea el usuario soka y entra con él; coincide con home.homeDirectory de home-manager.
    defaultUser = "soka";
    # SSH_AUTH_SOCK apunta a un puente con el ssh-agent de Windows, donde KeePassXC
    # carga las claves: las mismas sirven en Windows y aquí (install.ps1 arranca el servicio).
    ssh-agent.enable = true;
  };

  # Sin hardware-configuration.nix en WSL: la plataforma se fija aquí.
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "sokix-wsl";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  locales.es.enable = true;

  users.users.soka = {
    isNormalUser = true;
    description = "Victor Araque Casaus";
    extraGroups = [ "wheel" ];
  };

  programs.git.enable = true;

  # Cursor/VSCodium en modo "Remote WSL" copian aquí un servidor Node que no es
  # de Nix; nix-ld le da el cargador dinámico y las librerías que espera.
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    claude-code
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
