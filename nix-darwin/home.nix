# home.nix
# home-manager switch 

{ config, pkgs, ... }:

{
  home.username = "evgenijkislicenko";
  home.homeDirectory = "/Users/evgenijkislicenko";
  home.stateVersion = "24.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
#    ".zshrc".source = ~/dotfiles/.zshrc;
    ".config/wezterm".source = ~/dotfiles/wezterm;
    ".config/starship".source = ~/dotfiles/starship;
    ".config/nvim".source = ~/dotfiles/nvim;
    ".config/nix".source = ~/dotfiles/nix;
    ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    ".config/tmux".source = ~/dotfiles/tmux;
    ".config/lazygit".source = ~/dotfiles/lazygit;
    ".config/fish".source = ~/dotfiles/fish;
    ".config/k9s".source = ~/dotfiles/k9s;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];

  programs = {
      fzf.enable = true;
      home-manager.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      fish.enable = true;
  };
}
