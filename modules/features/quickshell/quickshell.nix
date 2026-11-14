{ ... }: {
	flake.modules.homeManager.quickshell = { ... }: {
		xdg.configFile."quickshell".source = ./config;
	};

	flake.modules.nixos.quickshell = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.quickshell
		];
	};
}
