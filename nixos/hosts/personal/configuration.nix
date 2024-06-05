# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./boot.nix
      ./locale.nix
      ./applications.nix
      ./gpu.nix
      ./graphical-environment.nix
      ./sound.nix
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #Enable networking
  networking.hostName = "sokix"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Configure console keymap
  console.keyMap = "es";

  #Define gamer group
  users.groups.gamer = {};  

  programs.ssh.startAgent = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soka = {
    isNormalUser = true;
    description = "Victor Araque Casaus";
    extraGroups = [ "networkmanager" "wheel" "gamer" ];
    packages = with pkgs; [
    ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
