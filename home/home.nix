{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lilin";
  home.homeDirectory = "/home/lilin";

  nixpkgs.config.allowUnfree = true;

  # No idea how to get this to work. Why the fuck is EVERYTHING in nix different?! Can't even declare variables.
  #systemConfigDirectory = "${home.homeDirectory}/Nixos/system/configuration.nix";
  #homeConfigDirectory = "${home.homeDirectory}/Nixos/home/home.nix";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  # # Adds the 'hello' command to your environment. It prints a friendly
  # # "Hello, world!" when run.
  # pkgs.hello

  # It is sometimes useful to fine-tune packages, for example, by applying
  # overrides. You can do that directly here, just don't forget the
  # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # fonts?
  #(pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # You can also create simple shell scripts directly inside your
  # configuration. For example, this adds a command 'my-hello' to your
  # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')
      nerd-fonts.jetbrains-mono
      cliphist
      wl-clipboard
      #mako
      fastfetch
      zathura
      anki
      lesspass-cli
      libreoffice-qt
      rclone
      qimgv
      nix-output-monitor
      nh
      pdftk

      libinput
      xournalpp

      # For screenshots
      hyprshot
      hyprsunset
      pulseaudio
      #grim
      #slurp
      #imagemagick

      smile
      yazi
      eza
      fzf
      bat
      zsh-fzf-tab
      csvlens
      gtrash
      devenv

      teams-for-linux
      #jellyfin-media-player
      thunderbird
      yt-dlp

      ffmpeg
      mpv
      htop
      swww
      gimp

      unzip
      zip
      cheat

      texliveFull
      texlivePackages.moderncv

      zellij
      ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lilin/etc/profile.d/hm-session-vars.sh
  #
  # Note that this works only when home manager is managing the shell. Otherwise any such variables have to be set somewhere else
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS=1; # This way the cursor is not invisible on wayland
  };

  programs.waybar.enable = true;

  services.swaync.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "viins";

    shellAliases = {
      ls = "eza --icons=always";
      ll = "eza -Alh --icons=always";
      l = "eza -alh --icons=always";
      la = "eza -A --icons=always";
      gp = "gtrash put";
      gf = "gtrash find";
      gr = "gtrash restore";
      cat = "bat";
      rg = "yazi";
      vim = "nvim $1";
      csv = "csvlens";
      down = "shutdown 0";
      sync = " rclone bisync ~/Documents pcloud:/Documents --verbose;\
	      rclone bisync ~/Bx pcloud:/Bx --verbose";

      update = "nh os switch \"$HOME/NixOS\" -- --impure";
      home = "nh home switch \"$HOME/NixOS\"";
    };

    syntaxHighlighting = {
      enable = true;
      styles = {
	command = "none";
	alias = "none";
	builtin = "none";
	precommand = "fg=magenta,bold";
	function = "fg=magenta";
	unknown-token = "fg=red";
      };
    };

    initContent = "autoload -U compinit; compinit
		 source ~/NixOS/HomeModules/fzf-tab/fzf-tab.plugin.zsh
		 bindkey \"^H\" backward-delete-char
		 bindkey \"^?\" backward-delete-char";

  };

  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
    shellAliases = {
      ls = "eza --icons=always";
      ll = "eza -Alh --icons=always";
      l = "eza -alh --icons=always";
      la = "eza -A --icons=always";
      gp = "gtrash put";
      gf = "gtrash find";
      gr = "gtrash restore";
      cat = "bat";
      rg = "yazi";
      vim = "nvim";
      csv = "csvlens";
      down = "shutdown 0";
      update = "nh os switch $\"($env.HOME)/NixOS\" -- --impure";
      home = "nh home switch $\"($env.HOME)/NixOS\"";
    };
    extraConfig = ''
      def sync [] {
        rclone bisync ~/Documents pcloud:/Documents --verbose  
        rclone bisync ~/Bx pcloud:/Bx --verbose
      }
    '';
    environmentVariables = {
      EDITOR = "nvim";
    };
  };


  programs.git = {
    enable = true;
    settings = {
      user = {
        name="Lilin";
        email="vxld100@tuta.io";
      };
    };
  };

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.quintom-cursor-theme;
    cursorTheme.name = "Quintom_Ink";
  };

  home.pointerCursor = {
    gtk.enable = true;

    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
  };

  programs.mpv = {
    enable = true;
    config = {
      gpu-context = "wayland";
    };
  };

  xdg.desktopEntries."com.github.iwalton3.jellyfin-media-player" = {
    name = "Jellyfin Media Player";
    comment = "Desktop client for Jellyfin";
    exec = "jellyfinmediaplayer --scale-factor 2";
    icon = "com.github.iwalton3.jellyfin-media-player";
    terminal = false;
    type = "Application";
    categories = [ "AudioVideo" "Video" "Player" "TV" ];
    actions = {
      "DesktopF" = {
	name = "Desktop [Fullscreen]";
	exec = "jellyfinmediaplayer --fullscreen --desktop --scale-factor 2";
      };
      "DesktopW" = {
	name = "Desktop [Windowed]";
	exec = "jellyfinmediaplayer --windowed --desktop --scale-factor 2";
      };
      "TVF" = {
	name = "TV [Fullscreen]";
	exec = "jellyfinmediaplayer --fullscreen --tv --scale-factor 2";
      };
      "TVW" = {
	name = "TV [Windowed]";
	exec = "jellyfinmediaplayer --windowed --tv --scale-factor 2";
      };
    };
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;

    autoGroups = {
      TexAutoCompile = { clear = true; };
    };

    autoCmd = [
    {
      event = "BufWritePost";
      pattern = "*.tex";
      command = "silent !bash -c \"cd '%:p:h' && xelatex '%:t' && cp '%:t:r.pdf' '..'\"";
      group = "TexAutoCompile";
    }
    {
      event = ["BufRead" "BufNewFile"];
      pattern = "*.tex";
      command = "setlocal textwidth=50 | echom \"Set textwidth to 50 for .tex file\"";
    }
    {
      event = ["BufRead" "BufNewFile"];
      pattern = "*.md";
      command = "setlocal textwidth=50 | echom \"Set textwidth to 50 for .md file\"";
    }
    ];
  };

  programs.alire.enable = true;

  xdg.desktopEntries = {
    qimgv = {
      name = "qimgv";
      exec = "env QT_SCALE_FACTOR=2.0 qimgv %F";
      icon = "qimgv";
      type = "Application";
      categories = [ "Graphics" "Viewer" ];
      mimeType = [ "image/jpeg" "image/png" "image/gif" ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
