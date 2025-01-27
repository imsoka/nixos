{pkgs, config, ...}:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    i3status
    dmenu
    nitrogen
  ];
  
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "es";
    xkb.variant = "";
  };
}
