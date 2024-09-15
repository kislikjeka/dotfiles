# home.nix
# home-manager switch 

{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home = {
    username = "evgenijkislicenko";
    homeDirectory = "/Users/evgenijkislicenko";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      neovim
      ripgrep
      zoxide
      obsidian
      eza
      tmux
      fzf
      git
      fd
      bat
      nixfmt-rfc-style
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];

  };

  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/evgenijkislicenko/dotfiles/lnvim";

  programs = {
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
