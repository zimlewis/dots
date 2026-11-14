{ ... }: {
	flake.modules.homeManager.starship = { pkgs, ... }: {
		xdg.configFile."starship.toml".source = ./config.toml;
	};

	flake.modules.nixos.starship = { pkgs, ... }: {
		programs.starship.enable = true;
		environment.systemPackages = [
			pkgs.starship
		];
	};
}