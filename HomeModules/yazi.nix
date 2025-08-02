{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener = {
        imv = [{ run = "setsid -f imv \"$@\""; }];
        zathura = [{ run = "setsid -f zathura \"$@\""; }];
        csvlens = [{ run = "setsid -f ghostty -e csvlens \"\'$0\'\""; }];
      };
      open = {
	prepend_rules = [
	  { name = "*.pdf"; use = "zathura"; }
	  { name = "*.jpg"; use = "imv"; }
	  { name = "*.jpeg"; use = "imv"; }
	  { name = "*.png"; use = "imv"; }
	  { name = "*.csv"; use = "csvlens"; }
	  { name = "*.xopp"; use = "xournalpp"; }
	];
      };
    };
  };
}

