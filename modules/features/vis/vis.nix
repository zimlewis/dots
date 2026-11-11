{ ... }: {
	flake.modules.homeManager.vis = { ... }: {
		xdg.configFile."vis".source = ./config;
	};

	flake.modules.nixos.vis = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.vis
			pkgs.file
			pkgs.fzf
		];
	};
}