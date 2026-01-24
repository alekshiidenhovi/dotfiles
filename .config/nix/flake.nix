{
  description = "Aleks' nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. 
      environment.systemPackages =
        [ 
          pkgs._1password-cli
          pkgs.antidote
          pkgs.cmake
          pkgs.cmake-language-server
          pkgs.dart
          pkgs.docker
          pkgs.docker-language-server
          pkgs.fd
          pkgs.fzf
          pkgs.gemini-cli
          pkgs.git
          pkgs.gh
          pkgs.lazygit
          pkgs.llvmPackages.libcxxClang
          pkgs.lua-language-server
          pkgs.mkalias
          pkgs.neovim
          pkgs.oh-my-posh
          pkgs.pnpm
          pkgs.ripgrep
          pkgs.ruff
          pkgs.rustup
          pkgs.rust-analyzer
          pkgs.sqruff
          pkgs.stow
          pkgs.tailwindcss-language-server
          pkgs.tree
          pkgs.tree-sitter
          pkgs.uv
          pkgs.zoxide
        ];

      homebrew = {
        enable = true;
        casks = [
          "1password"
          "docker-desktop"
          "figma"
          "font-hack-nerd-font"
          "ghostty"
          "google-chrome"
          "linear-linear"
          "mactex"
          "microsoft-outlook"
          "notion"
          "obsidian"
          "raycast"
          "slack"
          "spotify"
          "superhuman"
          "telegram"
          "todoist-app"
          "whatsapp"
          "zoom"
        ];
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = [ "/Applications" ];
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.primaryUser = "alekshiidenhovi";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#aleks-nix-darwin
    darwinConfigurations."aleks-nix-darwin" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
