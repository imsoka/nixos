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
  wsl.extraBin =
    let
      from = pkg: names: map (n: { src = "${pkg}/bin/${n}"; }) names;
    in
      from pkgs.coreutils [
        "uname" "date" "mktemp" "cp" "mv" "rm" "mkdir" "rmdir" "cat" "ls" "ln"
        "chmod" "chown" "touch" "dirname" "basename" "readlink" "realpath"
        "head" "tail" "sleep" "tr" "cut" "wc" "sort" "uniq" "tee" "id"
        "whoami" "env" "printf" "echo" "test" "stat" "sha256sum" "nohup" "timeout"
      ]
      ++ from pkgs.findutils [ "find" "xargs" ]
      ++ from pkgs.procps    [ "ps" "pkill" "pgrep" "kill" ]
      ++ from pkgs.gnused    [ "sed" ]
      ++ from pkgs.gnugrep   [ "grep" ]
      ++ from pkgs.gawk      [ "awk" ]
      ++ from pkgs.gnutar    [ "tar" ]
      ++ from pkgs.gzip      [ "gzip" "gunzip" ]
      ++ from pkgs.which     [ "which" ]
      ++ from pkgs.wget      [ "wget" ]
      ++ from pkgs.curl      [ "curl" ];

  environment.systemPackages = with pkgs; [
    home-manager
    claude-code
    wget
    curl
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
