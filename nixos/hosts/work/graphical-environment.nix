{pkgs, config, ...}:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.lightdm = {
    # enable = true;
    # greeters.gtk.enable = true;
  # };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.noctalia-greeter}/bin/noctalia-greeter-session";
      user = "greeter";
    };
  };

  environment.systemPackages = with pkgs; [
    noctalia-shell
    noctalia-greeter
    cage
    wlr-randr
  ];

  services.gnome.gnome-keyring.enable = true;

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    i3status
    dmenu
  ];
  
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "es";
    xkb.variant = "";
  };
}
