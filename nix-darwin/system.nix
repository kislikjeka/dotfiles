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
  };
  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Set Keyboard settings
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  fonts = {
    font = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };
}
