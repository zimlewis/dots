{ ... }: {
	flake.modules.homeManager.lf = { pkgs, ... }: {
		xdg.configFile."lf".source = ./config;
	};

	flake.modules.nixos.lf = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.lf
		];
	};
}
