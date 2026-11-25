{ ... }: {
	flake.modules.homeManager.zed = { ... }: {
		xdg.configFile."zed".source = ./config;
	};
	flake.modules.nixos.zed = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.zed-editor
		];
	};
}
