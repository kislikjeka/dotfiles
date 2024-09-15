{ pkgs, ... }:
{
  enable = true;
  shellInit = ''
    if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]
          fenv source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
        end
        set fish_greeting
  '';
}
