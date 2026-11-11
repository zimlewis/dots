{ ... }: {
	flake.modules.homeManager.alacritty = { pkgs, ... }: {
		xdg.configFile."alacritty".source = ./config;
		home.packages = [
			pkgs.nerd-fonts.caskaydia-mono
		];
	};

	flake.modules.nixos.alacritty = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.alacritty
		];
	};
}