# home.nix
# home-manager switch 

{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.username = "evgenijkislicenko";
  home.homeDirectory = "/Users/evgenijkislicenko";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs; [
    fd
    bat
    nixfmt-rfc-style
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".zshrc".source = ../.zshrc;
    # ".config/wezterm".source = ../wezterm;
    #   ".config/starship".source = ../starship;
    # ".config/nvim".source = ../nvim;
    ".config/nix".source = ../nix;
    ".config/nix-darwin".source = ../nix-darwin;
    ".config/lazygit".source = ../lazygit;
    # ".config/fish".source = ../fish;
    # ".config/k9s".source = ../k9s;
  };

  home.sessionVariables =
    {
    };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/evgenijkislicenko/dotfiles/lnvim";

  programs = {
    home-manager.enable = true;
    starship = (import ./modules/starship.nix { inherit pkgs; });
    zoxide = (import ./modules/zoxide.nix { inherit pkgs; });
    neovim = (import ./modules/neovim.nix { inherit config pkgs; });
    fish = (import ./modules/fish.nix { inherit pkgs; });
    zsh = (import ./modules/zsh.nix { inherit config pkgs; });
    tmux = (import ./modules/tmux.nix { inherit pkgs; });
    wezterm = (import ./modules/wezterm.nix { inherit pkgs; });
    k9s = (import ./modules/k9s.nix { inherit pkgs; });
  };
}
