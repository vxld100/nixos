{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener = {
        imv = [{ run = "imv \"$@\""; }];
        zathura = [{ run = "zathura \"$@\""; }];
      };
      open = {
	prepend_rules = [
	  { name = "*.pdf"; use = "zathura"; }
	  { name = "*.jpg"; use = "imv"; }
	  { name = "*.png"; use = "imv"; }
	];
      };
    };
  };
}

