{ moduleWithSystem, inputs, ... }: {
    flake.modules.homeManager.sonora = { pkgs, ... }: {
		xdg.configFile."sonora".source = ./config;
    };

    flake.modules.nixos.sonora = moduleWithSystem({ pkgs, self', ... }: {
        environment.systemPackages = [
			self'.packages.sonora
        ];
    });

	perSystem = { config, self', inputs', pkgs, system, ... }: {
		packages.sonora = inputs'.sonora.packages.default;
	};
}
