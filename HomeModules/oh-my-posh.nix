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
          segments = [
            {
              type = "path";
              style = "powerline";
              foreground = "p:blue";
              background = "transparent";
              properties = { 
				    style = "full"; 
				  };
				  template = "{{ if not .Writable }}󰌾 {{ end }}<b>{{ .Path }}<b>";
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
        {
          type = "rprompt";
          segments = [
            {
              type = "node";
              style = "plain";
              foreground = "p:green";
              background = "transparent";
              template = " ";
              properties = {
                display_mode = "files";
                fetch_package_manager = false;
                home_enabled = false;
              };
            }
            {
              type = "go";
              style = "plain";
              foreground = "p:blue";
              background = "transparent";
              template = " ";
              properties = {
                fetch_version = false;
              };
            }
            {
              type = "python";
              style = "plain";
              foreground = "p:yellow";
              background = "transparent";
              template = " ";
              properties = {
                display_mode = "files";
                fetch_version = false;
                fetch_virtual_env = false;
              };
            }
            {
              type = "shell";
              style = "plain";
              foreground = "p:white";
              background = "transparent";
              template = "in <p:blue><b>{{ .Name }}</b></> ";
            }
            {
              type = "time";
              style = "plain";
              foreground = "p:white";
              background = "transparent";
              template = "at <p:blue><b>{{ .CurrentDate | date \"15:04:05\" }}</b></>";
            }
          ];
        }
      ];
      tooltips = [
        {
          type = "aws";
          tips = [ "aws" ];
          style = "diamond";
          foreground = "p:white";
          background = "p:orange";
          leading_diamond = "";
          trailing_diamond = "";
          template = "  {{ .Profile }}{{ if .Region }}@{{ .Region }}{{ end }} ";
          properties = {
            display_default = true;
          };
        }
        {
          type = "az";
          tips = [ "az" ];
          style = "diamond";
          foreground = "p:white";
          background = "p:blue";
          leading_diamond = "";
          trailing_diamond = "";
          template = "  {{ .Name }} ";
          properties = {
            display_default = true;
          };
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
