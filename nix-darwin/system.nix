{
  self,
  pkgs,
  ...
}:
{
  system.defaults = {
    dock.autohide = true;
    dock.orientation = "bottom";
    dock.show-recents = false;

    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder.FXPreferredViewStyle = "clmv";
    finder.ShowPathbar = true;
  };
  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Set Keyboard settings
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  };
}
