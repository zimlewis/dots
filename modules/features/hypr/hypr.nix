{ ... }: {
	flake.modules.homeManager.hypr = { ... }: {
		xdg.configFile."hypr".source = ./config;
	};

	flake.modules.nixos.hypr = { pkgs, ... }: {
		programs.hyprland = {
			enable = true;
			package = pkgs.hyprland;
			# withUWSM = true;
		};
		hardware.graphics.enable = true;
		environment.systemPackages = [
			pkgs.hyprland
			pkgs.rofi
		];
	};
}