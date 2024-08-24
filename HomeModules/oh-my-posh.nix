{ config, lib, pkgs, ... }:

{
  config = {
    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      };
    };
  };
}
