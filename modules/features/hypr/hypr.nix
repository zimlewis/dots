{ ... }: {
	flake.modules.homeManager.hypr = { pkgs, ... }: {
		xdg.configFile."hypr".source = ./config;
		# home.pointerCursor = {
		# 	gtk.enable = true;
		# 	x11.enable = true;
		# 	package = pkgs.bibata-cursors;
		# 	name = "Bibata-Modern-Classic";
		# 	size = 16;
		# };
	};

	flake.modules.nixos.hypr = { pkgs, ... }: {
		programs.hyprlock.enable = true;
		programs.hyprland = {
			enable = true;
			package = pkgs.hyprland;
			withUWSM = true;
			xwayland.enable = true;
		};
		hardware.graphics.enable = true;
		environment.systemPackages = [
			pkgs.hyprland
			pkgs.hyprshot
			pkgs.hyprpicker
			pkgs.rofi
			pkgs.awww
			pkgs.hyprshutdown
		];
	};
}