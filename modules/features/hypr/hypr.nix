{ ... }: {
	flake.modules.homeManager.hypr = { ... }: {
		xdg.configFile."hypr".source = ./config;
	};

	flake.modules.nixos.hypr = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.hyprland
			pkgs.rofi
		];
	};
}