{ config, ... }: {
	flake.modules.homeManager.yazi = { ... }: {
		xdg.configFile."yazi".source = ./config;
	};

	flake.modules.nixos.yazi = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.yazi
		];
	};
}
