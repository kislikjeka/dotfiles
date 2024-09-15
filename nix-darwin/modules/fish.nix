{ pkgs, ... }:
{
  enable = true;
  shellInit = ''
    set fish greeting
  '';
}
