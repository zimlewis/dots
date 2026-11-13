{ self, inputs, ... }: {
	flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
		modules = with self.nixosModules; [
			laptopConfiguration
			homeManagerConfigurations
			users
			networking
			bootloader
			bluetooth
			settings
			locale
			environment
			features
		];
	};
}