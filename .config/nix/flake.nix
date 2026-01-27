{
  description = "Aleks' nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. 
      environment.systemPackages =
        [ 
          pkgs._1password-cli
          pkgs.biome
          pkgs.bun
          pkgs.cmake
          pkgs.cmake-language-server
          pkgs.dart
          pkgs.deno
          pkgs.docker
          pkgs.docker-language-server
          pkgs.fd
          pkgs.gemini-cli
          pkgs.gh
          pkgs.lazygit
          pkgs.lua-language-server
          pkgs.minikube
          pkgs.mkalias
          pkgs.neovim
          pkgs.nixd
          pkgs.nodejs_24
          pkgs.pnpm
          pkgs.ripgrep
          pkgs.ruff
          pkgs.rustup
          pkgs.rust-analyzer
          pkgs.sqruff
          pkgs.svelte-language-server
          pkgs.tailwindcss-language-server
          pkgs.tree
          pkgs.tree-sitter
          pkgs.uv
          pkgs.vtsls
          pkgs.vue-language-server
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

      system.defaults = {
        dock = {
          autohide = true;
          autohide-time-modifier = 0.5;
          largesize = 70;
          tilesize = 50;
          magnification = true;
          show-process-indicators = true;
          show-recents = true;
        };
        finder = {
          FXPreferredViewStyle = "Nlsv";
        };
        NSGlobalDomain = {
          AppleICUForce24HourTime = true;
          AppleShowAllExtensions = true;
        };
        CustomUserPreferences = {
          "com.apple.symbolichotkeys" = {
            AppleSymbolicHotKeys = {
              # 32 = Mission Control
              "32" = { enabled = false; };
              # 33 = Mission Control (dedicated key)
              "33" = { enabled = false; };
              # 35 = Application Windows
              "35" = { enabled = false; };

              # 60 = Spotlight Search
              "60" = { enabled = false; };
              # 61 = Spotlight Finder Window
              "61" = { enabled = false; };

              # 64 = Select previous input source (language)
              "64" = { enabled = false; };
              # 65 = Select next input source (language)
              "65" = { enabled = false; };

              # 79 = Move left a space (^←)
              "79" = { enabled = false; };
              # 80 = Move left a space (^←)
              "80" = { enabled = false; };
              # 81 = Move right a space (^→)
              "81" = { enabled = false; };
              # 82 = Move right a space (^→)
              "82" = { enabled = false; };
            };
          };
        };
      };

      system.primaryUser = "alekshiidenhovi";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.alekshiidenhovi = {
        name = "alekshiidenhovi";
        home = "/Users/alekshiidenhovi";
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.alekshiidenhovi = { config, lib, ... }: 
      let
        dotfilesPath = "${config.home.homeDirectory}/repos/dotfiles";
        
        # List the specific sub-directories or files you want to track
        managedFiles = [
          ".config/nvim"
          ".config/ghostty"
          ".config/nix"
          ".config/ohmyposh"
          ".config/zsh/aliases.zsh"
          ".config/zsh/keybindings.zsh"
          ".config/zsh/history_config.zsh"
          ".gitconfig"
          ".gitignore_global"
          ".zprofile"
        ];
      in {
        home.stateVersion = "25.11";
        
        home.file = lib.genAttrs managedFiles (name: {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${name}";
        });

        # .zshrc configuration
        programs = {
          zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;

            dotDir = "${config.home.homeDirectory}/.config/zsh";

            sessionVariables = {
              EDITOR = "nvim";
            };

            initContent = ''
              source ${config.home.homeDirectory}/.config/zsh/aliases.zsh
              source ${config.home.homeDirectory}/.config/zsh/keybindings.zsh
              source ${config.home.homeDirectory}/.config/zsh/history_config.zsh
            '';

            antidote = {
              enable = true;
              plugins = [''
                zsh-users/zsh-completions
                zdharma-continuum/fast-syntax-highlighting
                zsh-users/zsh-history-substring-search
              ''];
            };
          };

          oh-my-posh = {
            enable = true;
            configFile = "${config.home.homeDirectory}/.config/ohmyposh/default_config.toml";
          };

          fzf = {
            enable = true;
            enableZshIntegration = true;
          };

          zoxide = {
            enable = true;
            enableZshIntegration = true;
            options = [ "--cmd cd"];
          };

          git = {
            enable = true;
            settings = {
              user = {
                name = "Aleks Hiidenhovi";
                email = "hiidenhovi.aleks@gmail.com";
              };
              pull.rebase = true;
              init.defaultBranch = "main";
            };
          };
        };

      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#aleks-nix-darwin
    darwinConfigurations."aleks-nix-darwin" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
