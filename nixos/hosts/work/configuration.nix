# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  imports =
    [
      ./boot.nix
      ./locale.nix
      ./applications.nix
      ./gpu.nix
      ./graphical-environment.nix
      ./sound.nix
      ./hardware-configuration.nix
      ./ia.nix
      ./vpn-rema.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #Enable networking
  networking.hostName = "sokix-work"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 4321 9090 ];
    allowedUDPPorts = [ 4321 9090 ];
  };

  programs.ssh.startAgent = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soka = {
    isNormalUser = true;
    description = "Victor Araque Casaus";
    extraGroups = [ "networkmanager" "wheel" "input" "uinput" ];
  };

  # Typeless: lee el teclado (input) y escribe el texto dictado (uinput)
  hardware.uinput.enable = true;
  # Typeless lee el campo de texto activo por AT-SPI; sin el bus de
  # accesibilidad (org.a11y.Bus) avisa de "permiso de accesibilidad requerido"
  services.gnome.at-spi2-core.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Lector de huellas Synaptics 06cb:00bd (fprintd, enrolar con fprintd-enroll)
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.greetd.fprintAuth = true;
  # Pop-up de autenticación de polkit (agente de Noctalia)
  security.pam.services.polkit-1.fprintAuth = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
