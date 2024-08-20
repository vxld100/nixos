# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
		inputs.apple-silicon-support.nixosModules.apple-silicon-support
		#./../secrets/eduroam.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.stable;  # Changed from pkgs.nixFlakes
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];  # Added this line
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
       enable = true;
       efiSupport = true;
    };
  };

  # Specify path to peripheral firmware files.
  hardware.asahi = {
  	 enable = true;
    withRust = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    peripheralFirmwareDirectory = ./firmware;
	 #setupAsahiSound = false;
  };

  hardware.graphics.enable = true;

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings = {
	   General = {
		  Experimental = true;
	   };
    };
  };

  hardware.acpilight.enable = true;

  # Configuring systemd services
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
};

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
    hostName = "asahi";
    networkmanager = {
	   enable = true;
      wifi.backend = "iwd";
	 };
  };

  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "ch";
  #  useXkbConfig = true; # use xkb.options in tty.
  #};

  fonts.packages = with pkgs; [
	  noto-fonts
	  noto-fonts-cjk
	  noto-fonts-emoji
	  liberation_ttf
	  fira-code
	  fira-code-symbols
	  mplus-outline-fonts.githubRelease
	  dina-font
	  proggyfonts
	  nerdfonts
  ];

  # Enable Hyprland and the X11 windowing system.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.waybar.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "ch";
    };
  };

  services.displayManager.sddm.enable = true;


  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #sound.enable = true;
  services.pipewire = {
    enable = true;
	 #audio.enable = true;
    alsa = {
	   enable = true;
      support32Bit = true;
		};
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
	 wireplumber.extraConfig.bluetoothEnhancements = {
	  "monitor.bluez.properties" = {
		 "bluez5.a2dp.aac.bitratemode" = "0";  # 0 = constant bitrate
		 "bluez5.a2dp.aac.bitrate" = "320000";  # 320kbps
		 "bluez5.a2dp.aac.quality" = "7";  # Highest quality setting
	   };
	 };
  };


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lilin = {
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
	 curl
    firefox
    alacritty
    ranger
    dolphin
    git
    networkmanagerapplet
    wofi
	 brightnessctl
	 pavucontrol
	 dunst
	 pamixer
	 swaylock
	 openssl
	 unzip
	 zip

	 home-manager
  ];

  # This option is needed to make it so that sway unlocks at all. If it is not set, even the right password won't work
  security.pam.services.swaylock = {};
	
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
