{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener = {
        imv = [{ run = "setsid -f qimgv %s"; orphan=true; }];
        zathura = [{ run = "setsid -f zathura %s"; orphan=true; }];
        csvlens = [{ run = "setsid -f ghostty -e csvlens %s"; orphan=true; }];
      };
      open = {
	prepend_rules = [
	  { url = "*.pdf"; use = "zathura"; }
	  { url = "*.jpg"; use = "imv"; }
	  { url = "*.jpeg"; use = "imv"; }
	  { url = "*.png"; use = "imv"; }
	  { url = "*.csv"; use = "csvlens"; }
	  { url = "*.xopp"; use = "xournalpp"; }
	];
      };
    };
  };
}

