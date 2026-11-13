# Extra features that don't need to be cared for much
{ moduleWithSystem, ... }: {
	flake.modules.homeManager.extra = { ... }: {
	};

	flake.modules.nixos.extra = moduleWithSystem({ pkgs, self', ... }: {
		programs.nh = {
			enable = true;
			package = pkgs.nh;
			clean.enable = true;
			clean.extraArgs = "--keep 3";
		};
		environment.systemPackages = [
			pkgs.tree
			pkgs.just
			pkgs.imv
			pkgs.mpv
			pkgs.lf
			pkgs.nnn
			pkgs.nh

			self'.packages.zen-browser
		];
	});


	perSystem = { config, self', inputs', pkgs, system, ... }: {
		packages.zen-browser = inputs'.zen-browser.packages.default;
	};
}
