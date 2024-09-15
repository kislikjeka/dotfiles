{ pkgs, ... }:
{
  enable = true;
  shellInit = ''
    set fish_greeting
  '';
}
