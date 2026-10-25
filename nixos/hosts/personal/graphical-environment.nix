{pkgs, config, ...}:

{
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

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    vimix-icon-theme
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
