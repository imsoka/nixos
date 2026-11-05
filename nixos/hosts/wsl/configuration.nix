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

  # El instalador del servidor de Cursor corre en un shell no interactivo sin el
  # PATH de NixOS: espera estas herramientas en /bin.
  wsl.extraBin = with pkgs; [
    { src = "${coreutils}/bin/uname"; }
    { src = "${coreutils}/bin/dirname"; }
    { src = "${coreutils}/bin/readlink"; }
    { src = "${coreutils}/bin/mkdir"; }
    { src = "${coreutils}/bin/rm"; }
    { src = "${coreutils}/bin/mv"; }
    { src = "${coreutils}/bin/cat"; }
    { src = "${coreutils}/bin/chmod"; }
    { src = "${coreutils}/bin/ln"; }
    { src = "${coreutils}/bin/sleep"; }
    { src = "${coreutils}/bin/head"; }
    { src = "${coreutils}/bin/id"; }
    { src = "${gnused}/bin/sed"; }
    { src = "${gnugrep}/bin/grep"; }
    { src = "${gnutar}/bin/tar"; }
    { src = "${gzip}/bin/gzip"; }
    { src = "${wget}/bin/wget"; }
    { src = "${curl}/bin/curl"; }
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    claude-code
    wget
    curl
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
