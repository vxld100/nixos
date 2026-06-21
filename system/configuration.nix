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

  nixpkgs.overlays = [ (final: prev: {
    lix = prev.lixPackageSets.stable.lix;
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];

  nix = {
    package = pkgs.lix;  # Changed from pkgs.nixFlakes
      # Here I used to have also flake-repl as an experimental feature, but at some point it wouldn't build anymore
      extraOptions = ''
      experimental-features = nix-command flakes 
      '';
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];  # Added this line
      trusted-users = [ "root" "@wheel" ];
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
      default = 93;
    };
  };

  boot.kernelParams = [ "appledrm.show_notch=1" ];

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  security.unprivilegedUsernsClone = true;

# Specify path to peripheral firmware files.
  hardware.asahi = {
    enable = true;
    peripheralFirmwareDirectory = ./firmware;
#setupAsahiSound = false;
  };

  hardware.graphics.enable = true;

  # Bluetooth power management
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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

  # for kde connect
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } 
    ];
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } 
    ];
  };

  services.blueman.enable = true;

# Set your time zone.
  time.timeZone = "Europe/Berlin";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
   #font = "Lat2-Terminus16";
   #keyMap = "sg";
   useXkbConfig = true; # use xkb.options in tty.
 };

 i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk           # For GTK2/3/4 applications like Ghostty
      fcitx5-lua           # Required for some configuration options
    ];
  };

# Enable Hyprland and the X11 windowing system.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #programs.waybar.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "ch";
        model="applealupce";
        variant = "";
      };
    };
  };

  services.displayManager.ly = {
    enable = true;
  };


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
    wireplumber.extraConfig = {
      "50-bt-latency" = {
        "monitor.bluez.rules" = [
          {
            matches = [
              { "node.name" = "~bluez_output.*"; }
            ];
            actions = {
              "update-props" = {
                "latency.internal.ns" = 100000000; # 100ms buffer cushion
              };
            };
          }
        ];
      };
    };
# If you want to use JACK applications, uncomment this
#jack.enable = true;
  };

# Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lilin = {
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = [ "wheel" "networkmanager" "video" "multimedia" ]; # Enable ‘sudo’ for the user.
      useDefaultShell = true;
  };

  users.groups.multimedia = {};

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ranger
      wget
      curl
      firefox
      brave
      alacritty
      yazi
      kdePackages.dolphin
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

  services.mullvad-vpn = {
    enable = true;
  };

  services = {
    jellyfin = { enable = false; group = "multimedia"; };
    sonarr = { enable = false; group = "multimedia"; };
    radarr = { enable = false; group = "multimedia"; };
    lidarr = { enable = false; group = "multimedia"; };
    prowlarr = { enable = false; };
    transmission = {
      enable = false;
      package = pkgs.transmission_4;
      group = "multimedia";
      settings = {
	download-dir = "/media/downloads/unsorted";
	incomplete-dir = "/media/downloads/processing";
	incomplete-dir-enabled = true;
      };
    };
  };

  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings.server = {
      bind_address = "127.0.0.1";
      port = 8888;
      secret_key = "8116f76451814758582cd6c9e1cebcea549e40c7807f83b87421be5d952eada9";
    };
  };

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
