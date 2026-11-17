{ ... }: {
	flake.modules.homeManager.quickshell = { pkgs, ... }: {
		xdg.configFile."quickshell".source = ./config;
		home.packages = [
			pkgs.material-symbols
		];
	};

	flake.modules.nixos.quickshell = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.qt6.qt5compat
			pkgs.quickshell
		];
	};
}
