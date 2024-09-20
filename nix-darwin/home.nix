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
      just
      ripgrep
      obsidian
      eza
      fzf
      git
      fd
      bat
      nixfmt-rfc-style
      home-manager
      go
    ];

    sessionVariables = rec {
      EDITOR = "nvim";
      VISUAL = "nvim";
      GOPATH = "${config.xdg.dataHome}/go";
      GOBIN = "${GOPATH}/bin";
    };

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];

  };

  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/evgenijkislicenko/dotfiles/nvim";

  programs = {
    home-manager.enable = true;
    starship = (import ./modules/starship.nix { inherit pkgs; });
    # git = (import ./modules/git.nix { inherit pkgs; });
    zoxide = (import ./modules/zoxide.nix { inherit pkgs; });
    neovim = (import ./modules/neovim.nix { inherit config pkgs; });
    zsh = (import ./modules/zsh.nix { inherit config pkgs; });
    tmux = (import ./modules/tmux.nix { inherit pkgs; });
    wezterm = (import ./modules/wezterm.nix { inherit pkgs; });
    k9s = (import ./modules/k9s.nix { inherit pkgs; });
    lazygit.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
