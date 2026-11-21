{ ... }: {
	flake.modules.homeManager.vencord = { pkgs, ... }: {
	};

	flake.modules.nixos.vencord = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.discord
			pkgs.vencord
		];
	};
}
