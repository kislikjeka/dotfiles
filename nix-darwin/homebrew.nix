_: {
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    # Automatically remove packages not contained in list
    # onActivation.cleanup = "zap";
    global.brewfile = true;
    masApps = { };
    taps = [
      # "homebrew/cask-versions"
    ];
    # Ideally leave this empty and only use nix to manage this
    brews = [ ];
    casks = [
      # "discord"
      "raycast"
      "nikitabobko/tap/aerospace"
      "zed"
      "ghostty"
      # "spotify"
      # "visual-studio-code"
      # "vlc"
    ];
  };
}
