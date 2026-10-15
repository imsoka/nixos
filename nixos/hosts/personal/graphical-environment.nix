{pkgs, config, ...}:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.noctalia-greeter}/bin/noctalia-greeter-session";
      user = "greeter";
    };
  };

  programs.niri.enable = true;

  # setuid wrapper for pkexec (off by default in the polkit module)
  security.polkit.enablePkexecWrapper = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    i3status
    dmenu
  ];

  services.picom.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    vimix-icon-theme
    lxappearance
    noctalia-shell
    noctalia-greeter
    cage
    wlr-randr
  ];
  
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "es";
    xkb.variant = "";
  };
}
