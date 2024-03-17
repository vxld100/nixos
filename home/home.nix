{ config, pkgs, ... }:

{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "lilin";
	home.homeDirectory = "/home/lilin";

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
	 	 (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

	 	 # You can also create simple shell scripts directly inside your
	 	 # configuration. For example, this adds a command 'my-hello' to your
	 	 # environment:
	 	# (pkgs.writeShellScriptBin "my-hello" ''
	 	#   echo "Hello, ${config.home.username}!"
	 	# '')
			cliphist
			wl-clipboard
			neofetch
			micromamba
			zathura
			anki
			lesspass-cli
			texlive.combined.scheme-medium
			libreoffice-qt
			rclone
			imv
			pgadmin4-desktopmode
			
			# For screenshots
			grim
			slurp
			imagemagick

			ffmpeg
			mpv
			htop
			swww

			unzip
			zip
			cheat
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
	 	#EDITOR = "nvim";
	 	#SUDO_EDITOR = "nvim";
	 	WLR_NO_HARDWARE_CURSORS=1; # This way the cursor is not invisible on wayland
	};

	programs = {
   	direnv = {
   		enable = true;
      	enableBashIntegration = true; # see note on other shells below
			nix-direnv.enable = true;
    	};

		zsh = {
			enable = true;
			autocd = true;
			defaultKeymap = "viins";

			shellAliases = {
				ll = "ls -Alhp";
				la = "ls -Ahp";
				rg = "ranger";
				vim = "nvim $1";
				down = "shutdown 0";
				sync = "sudo rclone bisync ~/Uni pcloud:/Uni --verbose; sudo chown -R lilin:users ~/Uni";

				update = "sudo nixos-rebuild switch -I nixos-config=$HOME/NixOS/system/configuration.nix";
				home = "home-manager switch -f $HOME/NixOS/home/home.nix";
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

			antidote = {
				enable = true;
				plugins = [
					"romkatv/powerlevel10k"
				];
			};

			initExtraFirst = ''
if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
	source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
fi
			'';
			initExtra = ''
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

eval "$(direnv hook zsh)"
			'';

		};
	};


	programs.git = {
	 	enable = true;
	 	userName  = "Lilin";
	 	userEmail = "vxld100@tuta.io";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
