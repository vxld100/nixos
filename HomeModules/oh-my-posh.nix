{
  programs.oh-my-posh = {
    enable = true;
    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      version = 2;
      final_space = true;
      console_title_template = "{{ .Shell }} in {{ .Folder }}";
      blocks = [
        {
          type = "prompt";
          alignment = "left";
			 newline = true;
          segments = [
			   {
				  type = "os";
				  style = "plain";
				  foreground = "#26C6DA";
				  background = "transparent";
				  template = "{{.Icon}}  "; # This requires two spaces due to the size of some icons, e.g., nix flake
				}
            {
              type = "path";
              style = "powerline";
              foreground = "p:blue";
              background = "transparent";
              properties = { 
				    style = "full"; 
				  };
				  template = "{{ if not .Writable }}󰌾 {{ end }}<b>{{ .Path }} <b>";
            }
				{
				  type = "git";
				  style = "plain";
				  foreground = "#b4aae3";
				  background = "transparent";
				  template = "{{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }}";
				  properties = {
					 fetch_status = true;
					 fetch_upstream_icon = true;
					 untracked_modes = {
						"/Users/user/Projects/oh-my-posh/" = "no";
					 };
					 source = "cli";
					 mapped_branches = {
						"feat/*" = "🚀 ";
						"bug/*" = "🐛 ";
					 };
				  };
				}
				{
				type = "prompt";
				alignment = "left";
				newline = "true";
				}
          ];
        }
        {
          type = "prompt";
			 alignment = "right";
          segments = [
				{
				  type = "nix-shell";
				  style = "plain";
				  foreground = "p:blue";
				  background = "transparent";
				  template = "(nix-{{ .Type }})";
				  properties = {
				    always_enabled = true;
				  };
				}
            {
              type = "R";
              style = "plain";
              foreground = "p:blue";
              background = "transparent";
              template = "  {{ .Full }} ";
				  properties = {
				    display_mode = "context";
				  };
            }
            {
              type = "node";
              style = "plain";
              foreground = "p:green";
              background = "transparent";
              template = "  {{ .Full }} ";
				  properties = {
				    display_mode = "context";
				  };
            }
            {
              type = "go";
              style = "plain";
              foreground = "p:blue";
              background = "transparent";
              template = "  {{ .Full }} ";
				  properties = {
				    display_mode = "context";
				  };
            }
            {
              type = "python";
              style = "plain";
              foreground = "p:yellow";
              background = "transparent";
              template = "  {{ .Full }} ";
				  properties = {
				    display_mode = "context";
				  };
            }
            {
              type = "executiontime";
              style = "powerline";
              foreground = "p:white";
              background = "transparent";
              template = "took <p:blue><b>{{ .FormattedMs }}</b></>";
				  properties = {
				    threshold = 500;
					 style = "austin";
					 always_enabled = false;
				  };
            }
          ];
        }
		  {
		    type = "prompt";
			 alignment = "left";
			 newline = true;
			 segments = [
				{
				  type = "text";
				  style = "plain";
				  foreground_templates = [
					 "{{if gt .Code 0}}red{{end}}"
					 "{{if eq .Code 0}}magenta{{end}}"
				  ];
				  background = "transparent";
				  template = "❯";
				}
			 ];
		  }
      ];
		 transient_prompt = {
		  style = "plain";
		  foreground_templates = [
			 "{{if gt .Code 0}}red{{end}}"
			 "{{if eq .Code 0}}magenta{{end}}"
		  ];
		  background = "transparent";
		  template = "❯ ";
		  };
      palette = {
        black = "#262B44";
        blue = "#4B95E9";
        green = "#59C9A5";
        orange = "#F07623";
        red = "#D81E5B";
        white = "#E0DEF4";
        yellow = "#F3AE35";
      };
    };
  };
}
