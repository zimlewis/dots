{ ... }: {
	flake.nixosModules.laptopConfiguration = { ... }: {
		imports = [
			./_hardware-configuration.nix
		];

		environment.pathsToLink = [
			"/share/xdg-desktop-portal"
			"/share/applications"
		];
		system.stateVersion = "26.05"; 	
	};
}