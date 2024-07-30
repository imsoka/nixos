{pkgs, config, ...}:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  security.pam.services.login.enableKwallet = true;

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    i3status
    dmenu
    nitrogen
    pasystray
  ];
  
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "es";
    xkb.variant = "";
  };
}
