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

			", XF86MonBrightnessUp, exec, brightnessctl set +20";
			", XF86MonBrightnessDown, exec, brightnessctl set 20-";
			"$mainMod, XF86MonBrightnessUp, exec, xbacklight -ctrl kbd_backlight -inc 25";
			"$mainMod, XF86MonBrightnessDown, exec, xbacklight -ctlr kbd_backlight -dec 25";
		 ];

		 bindm = [
		   "$ModShift, mouse:272, movewindow";
			"$mainMod, mouse:273, resizewindow";
		 ];
	  };
	};
}
