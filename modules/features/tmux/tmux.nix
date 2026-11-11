{ ... }: {
	flake.modules.homeManager.tmux = { ... }: {
		xdg.configFile."tmux".source = ./config;
	};

	flake.modules.nixos.tmux = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.tmux
		];
	};
}