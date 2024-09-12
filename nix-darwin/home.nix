# home.nix
# home-manager switch 

{ config, pkgs, ... }:

{
  home.username = "evgenijkislicenko";
  home.homeDirectory = "/Users/evgenijkislicenko";
  home.stateVersion = "24.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs;[
  fd
  bat
  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = ../.zshrc;
    ".config/wezterm".source = ../wezterm;
 #   ".config/starship".source = ../starship;
    ".config/nvim".source = ../nvim;
    ".config/nix".source = ../nix;
    ".config/nix-darwin".source = ../nix-darwin;
    ".config/lazygit".source = ../lazygit;
    ".config/fish".source = ../fish;
    ".config/k9s".source = ../k9s;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  
  xdg.enable = true;

  programs = {
      atuin.enable = true;
      ripgrep.enable = true;
      fzf.enable = true;
      home-manager.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      fish.enable = true;
      zsh.enable = true;
      tmux = (import ./modules/tmux.nix { inherit pkgs; });
  };
}
