# Extra features that don't need to be cared for much
{ moduleWithSystem, ... }: {
	flake.modules.homeManager.extra = { ... }: {
	};

	flake.modules.nixos.extra = moduleWithSystem({ pkgs, self', ... }: {
		environment.systemPackages = [
			pkgs.tree
			pkgs.just
			pkgs.imv
			pkgs.mpv
			pkgs.lf
			pkgs.nnn

			self'.packages.zen-browser
		];
	});


	perSystem = { config, self', inputs', pkgs, system, ... }: {
		packages.zen-browser = inputs'.zen-browser.packages.default;
	};
}
