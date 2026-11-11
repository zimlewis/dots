{ ... }: {
	flake.nixosModules.laptopConfiguration = { ... }: {
		imports = [
			./_hardware-configuration.nix
		];
	};
}