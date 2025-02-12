{
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;

      cursor = {
        unfocused_hollow = false;
        style = {
          blinking = "Off";
          shape = "Underline";
        };
        vi_mode_style = {
          blinking = "On";
          shape = "Block";
        };
      };

      env = {
        TERM = "xterm-256color";
      };

      font = {
        size = 30.0;
        normal = {
          family = "JetBrains Mono Nerd Font";
        };
      };

      keyboard.bindings = [
        {
          action = "ToggleViMode";
          key = "N";
          mode = "~Search";
          mods = "Control";
        }
      ];

      window = {
        decorations = "full";
        dynamic_title = true;
        startup_mode = "Windowed";
        blur = true;
        dimensions = {
          columns = 82;
          lines = 25;
        };
        padding = {
          x = 36;
          y = 36;
        };
      };

      colors = {
        cursor = {
          cursor = "#F5E0DC";
          text = "#181F21";
        };
        hints = {
          end = {
            background = "#A6ADC8";
            foreground = "#181F21";
          };
          start = {
            background = "#E0E0DE";
            foreground = "#181F21";
          };
        };
        primary = {
          background = "#0b0c0d";
          bright_foreground = "#BDBEB0";
          dim_foreground = "#BDBEB0";
          foreground = "#BDBEB0";
        };
        search = {
          focused_match = {
            background = "#BDBEB0";
            foreground = "#181F21";
          };
          matches = {
            background = "#A6ADC8";
            foreground = "#181F21";
          };
        };
        selection = {
          background = "#F5E0DC";
          text = "#181F21";
        };
        vi_mode_cursor = {
          cursor = "#393C3E";
          text = "#181F21";
        };
      };
    };
  };
}

