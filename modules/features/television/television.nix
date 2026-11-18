{ ... }: {
	flake.modules.homeManager.television = { ... }: {
		xdg.configFile."television".source = ./config;
	};

	flake.modules.nixos.television = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.television
			pkgs.ripgrep
			pkgs.fd
		];
	};
}