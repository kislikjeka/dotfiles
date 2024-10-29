# home.nix
# home-manager switch 

{ config, pkgs, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  dotfiles = "${config.home.homeDirectory}/dotfiles";
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
      nixd
      rustup
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

    file = {
      ".config/wezterm" = {
        source = link "${dotfiles}/wezterm";
        recursive = true;
      };
    };

  };

  xdg.enable = true;
  # wezterm produces its own wezterm.lua file which causes conflict
  xdg.configFile."wezterm/wezterm.lua".enable = false;
  xdg.configFile.nvim.source = link "${dotfiles}/nvim";

  programs = {
    home-manager.enable = true;
    starship = (import ./modules/starship.nix { inherit pkgs; });
    zoxide = (import ./modules/zoxide.nix { inherit pkgs; });
    neovim = (import ./modules/neovim.nix { inherit config pkgs; });
    zsh = (import ./modules/zsh.nix { inherit config pkgs; });
    tmux = (import ./modules/tmux.nix { inherit pkgs; });
    wezterm = {
      enable = true;
      enableZshIntegration = true;
    };
    k9s = (import ./modules/k9s.nix { inherit pkgs; });
    lazygit.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      config.global.hide_env_diff = true;
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

          condition = "hasconfig:remote.*.url:https://github.com/inDriver/*";
        }
      ];
    };
  };
}
