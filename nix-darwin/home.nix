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
    ];

    sessionVariables = rec {
      EDITOR = "nvim";
      VISUAL = "nvim";
      GO111MODULE = "on";
    };

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
      "$HOME/go/bin"
      "$HOME/.local/bin"
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
    go = {
      enable = true;
      package = pkgs.go_1_22;
      goPath = "go";
      goBin = "go/bin";
    };
    git = {
      enable = true;
      userName = "kislikjeka";
      userEmail = "kislichenkojeka@mail.ru";

      ignores = [
        ".envrc"
        ".idea"
        ".DS_Store"
        ".env"
        ".pre-commit-config.yaml"
      ];
      extraConfig = {
        core = {
          sshCommand = "ssh -i ~/.ssh/id_ed_personal";
          autocrlf = true;
        };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
      };

      includes = [
        {
          contents = {
            user = {
              name = "Evgenii Kislichenko";
              email = "evgenii.kislichenko@indriver.com";
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/id_ed25519";
            };
          };

          condition = "hasconfig:remote.*.url:git@github.com:inDriver/*";
        }
      ];
    };
  };
}
