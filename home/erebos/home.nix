{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "erebos";
  home.homeDirectory = "/home/erebos";

  nixpkgs.config.allowUnfree = true;

  # State version for the stable channel
  home.stateVersion = "24.11";

  # Packages to install
  home.packages = with pkgs; [
    # Server and system utilities
    htop
    btop
    iotop
    iftop
    nmap
    tcpdump
    lsof
    ethtool
    
    # Development tools
    git
    tmux
    ripgrep
    fd
    jq
    curl
    wget
    
    # Enhanced command line tools
    yazi
    eza
    fzf
    bat
    csvlens
    gtrash
    cheat
    
    # Archive utilities
    unzip
    zip
    
    # Monitoring and management
    nix-output-monitor
    nh
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
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
      
      # Server-specific aliases
      update = "nh os switch \"$HOME/NixOS\" -- --impure";
      home = "nh home switch \"$HOME/NixOS\"";
      
      # Monitoring aliases
      sysinfo = "htop";
      netinfo = "iftop -i $(ip route | grep default | awk '{print $5}')";
      diskinfo = "df -h";
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

    initExtra = "autoload -U compinit; compinit
                 source ~/NixOS/HomeModules/fzf-tab/fzf-tab.plugin.zsh
                 bindkey \"^H\" backward-delete-char
                 bindkey \"^?\" backward-delete-char";
  };

  programs.git = {
    enable = true;
    userName = "erebos";
    userEmail = "erebos@datacenter.com";  # Replace with actual email
  };


  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;

    autoCmd = [
      {
        event = ["BufRead" "BufNewFile"];
        pattern = "*.md";
        command = "setlocal textwidth=50 | echom \"Set textwidth to 50 for .md file\"";
      }
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
