{
	wayland.windowManager.hyprland = {
	  enable = true;
	  settings = {
	    "monitor" = ",preferred,auto,1";

		 exec-once = [
		   "waybar"
			"bluetoothctl power off"
			"nm-applet"
			"wl-paste --type text --watch cliphist store"
			"wl-paste --type image --watch cliphist store"
			"swww init"
			"mako"
			"hyprpaper"
		 ];

		 general = {
		    gaps_in = 10;
			 gaps_out = 40;
			 border_size = 4;
			 #col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
			 #col.active_border = rgba(FF4500FF) rgba(898989aa) rgba(FF4500FF) 30deg
			 "col.active_border" = "rgba(33ccffee) rgba(9F9F9Fee) rgba(33ccffee) 30deg";
			 "col.inactive_border" = "rgba(595959aa)";

			 layout = "dwindle";

			 no_focus_fallback = true;
			 no_focus_fallback = true;
			 resize_on_border = true;
		 };

		 input = {
			 kb_layout = "ch,ru";
			 kb_variant = ",phonetic";
			 kb_options = "grp:alt_shift_toggle";

			 follow_mouse = 2;
			 mouse_refocus = false;

			 repeat_rate = 50;
			 repeat_delay = 200;

			 touchpad {
				  natural_scroll = yes
			 };

			 sensitivity = 0.4; # -1.0 - 1.0, 0 means no modification.
		 };

		 cursor = {
		   no_warps = true;
		 };

		 "$mainMod" = "SUPER";
		 "$ModShift" = "SUPERSHIFT";
		 "$ModAlt" = "SUPERALT";
		 "ModCtrl" = "SUPERCTRL";

		 bind = [
		   "$mainMod, h, movefocus, l";
			"$mainMod, l, movefocus, r";
			"$mainMod, k, movefocus, u";
			"$mainMod, k, movefocus, u";
			"$ModShift, h, movewindow, l";
			"$ModShift, l, movewindow, r";
			"$ModShift, k, movewindow, u";
			"$ModShift, j, movewindow, d";

			"$mainMod, 1, workspace, 1";
			"$mainMod, 2, workspace, 2";
			"$mainMod, 3, workspace, 3";
			"$mainMod, 4, workspace, 4";
			"$mainMod, 5, workspace, 5";
			"$mainMod, 6, workspace, 6";
			"$mainMod, 7, workspace, 7";
			"$mainMod, 8, workspace, 8";
			"$mainMod, 9, workspace, 9";
			"$mainMod, 10, workspace, 10";

			"$mainMod SHIFT, 1, movetoworkspace, 1";
			"$mainMod SHIFT, 2, movetoworkspace, 2";
			"$mainMod SHIFT, 3, movetoworkspace, 3";
			"$mainMod SHIFT, 4, movetoworkspace, 4";
			"$mainMod SHIFT, 5, movetoworkspace, 5";
			"$mainMod SHIFT, 6, movetoworkspace, 6";
			"$mainMod SHIFT, 7, movetoworkspace, 7";
			"$mainMod SHIFT, 8, movetoworkspace, 8";
			"$mainMod SHIFT, 9, movetoworkspace, 9";
			"$mainMod SHIFT, 10, movetoworkspace, 10";

			"$mainMod, mouse_down, workspace, e+1";
			"$mainMod, mouse_up, workspace, e-1";
			"$mainMod,Tab,workspace,previous";
		 ];

		 bindm = [
		   "$ModShift, mouse:272, movewindow";
			"$mainMod, mouse:273, resizewindow";
		 ];
	  };
	};
}
