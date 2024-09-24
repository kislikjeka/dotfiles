{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nix-homebrew,
      homebrew-cask,
      nixpkgs,
      home-manager,
    }:
    let
      configuration =
        { pkgs, lib, ... }:
        {
          imports = [
            (import ./system.nix { inherit self pkgs; })
            ./homebrew.nix
          ];

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nix.optimise.automatic = true;
          nix.gc = {
            automatic = true;
            interval = {
              Weekday = 0;
              Hour = 0;
              Minute = 0;
            };
            options = "--delete-older-than 30d";
          };

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.config.allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "obsidian"
            ];

          programs.zsh.enable = true;

          nix.configureBuildUsers = true;
          users.users.evgenijkislicenko = {
            home = "/Users/evgenijkislicenko";
            shell = pkgs.zsh;
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Evgenijs-MacBook-Pro
      darwinConfigurations."Evgenijs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "evgenijkislicenko";
              autoMigrate = true;
              taps = {
                "homebrew/homebrew-cask" = homebrew-cask;
              };
            };
          }
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.evgenijkislicenko = import ./home.nix;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Evgenijs-MacBook-Pro".pkgs;
    };
}
