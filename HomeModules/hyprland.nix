{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "monitor" = ",preferred,auto,1";

      exec-once = [
        "waybar"
        "bluetoothctl power off"
        "systemctl stop transmission.service"
        "nm-applet"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "swww init"
        "mako"
      ];

      exec = "hyprpaper";

      general = {
        gaps_in = 10;
        gaps_out = 40;
        border_size = 4;
        "col.active_border" = "rgba(33ccffee) rgba(9F9F9Fee) rgba(33ccffee) 30deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        no_focus_fallback = true;
        resize_on_border = true;
      };

      decoration = {
	rounding = 10;
	
	shadow = {
	  enabled = true;
	  render_power = 3;
	  color = "rgba(1a1a1aee)";
	};

        blur = {
          enabled = true;
          size = 8;
          passes = 1;
          ignore_opacity = false;
        };
      };

      animations = {
	enabled = true;
	bezier = [
	  "myBezier, 0.05, 0.9, 0.1, 1.08"
	];
	animation = [
	  "windows, 1, 4, myBezier"
	  "windowsOut, 1, 4, default, popin 80%"
	  "border, 1, 10, default"
	  "borderangle, 1, 8, default"
	  "fade, 1, 7, default"
	  "workspaces, 1, 4, myBezier"
	];
      };


      binds = {
        allow_workspace_cycles = true;
      };

      windowrule = "opacity 0.9 0.9,^(Alacritty)$";

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe = "off";
      };

      input = {
        kb_layout = "ch,ru";
        kb_variant = ",phonetic";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 2;
        mouse_refocus = false;
        repeat_rate = 50;
        repeat_delay = 200;
        touchpad = {
          natural_scroll = "yes";
        };
        sensitivity = 0.4; # -1.0 - 1.0, 0 means no modification.
      };

      cursor = {
        no_warps = true;
      };

      "$mainMod" = "SUPER";
      "$ModShift" = "SUPERSHIFT";
      "$ModAlt" = "SUPERALT";
      "$ModCtrl" = "SUPERCTRL";

      bind = [
        "$mainMod, Return, exec, alacritty"
        "$mainMod, C, killactive, "
        "$ModShift, Q, exit, "
        "$mainMod, E, exec, alacritty --hold -e ranger ~"
        "$mainMod, R, exec, alacritty --hold -e ranger ~/Uni"
        "$mainMod, V, togglefloating, "
        "$mainMod, S, exec, wofi --show=drun -i --matchin=fuzzy --normal-window --prompt=\"Choose application to run\""
        "$mainMod, P, pseudo, "
        "$mainMod, F, fullscreen, "
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$ModShift, h, movewindow, l"
        "$ModShift, l, movewindow, r"
        "$ModShift, k, movewindow, u"
        "$ModShift, j, movewindow, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 10, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, Tab, workspace, previous"
        "$ModCtrl, L, exec, swaylock -c 000000"
        "$mainMod, W, exec, brave --force-device-scale-factor=2 --enable-features=BatterySaver --enable-tab-discarding --disable-background-networking"
      ];

      bindm = [
        "$ModShift, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        "$mainMod, y, exec, grim -g \"$(slurp)\" - | convert - -shave 1x1 PNG:- | wl-copy"
        ", XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volumecontrol.sh -o d"
        ", XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volumecontrol.sh -o i"
        "$ModShift, o, exec, ~/.config/hypr/scripts/volumecontrol.sh -o d"
        "$mainMod, o, exec, ~/.config/hypr/scripts/volumecontrol.sh -o i"
        "$mainMod, u, exec, ~/.config/hypr/scripts/headphones.sh"
        "$mainMod, i, exec, ~/.config/hypr/scripts/wallpaper.sh"
        ", XF86AudioMute, exec, ~/.config/hypr/scripts/volumecontrol.sh -o m"
        ", XF86AudioMicMute, exec, ~/.config/hypr/scripts/volumecontrol.sh -i m"
        "$mainMod, XF86MonBrightnessUp, exec, xbacklight -ctrl kbd_backlight -inc 25"
        "$mainMod, XF86MonBrightnessDown, exec, xbacklight -ctlr kbd_backlight -dec 25"
      ];
    };
  };
}

