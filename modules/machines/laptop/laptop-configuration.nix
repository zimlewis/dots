{ self, inputs, ... }: {
	flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
		modules = with self.nixosModules; [
			laptopConfiguration
			users
			networking
			bootloader
			bluetooth
			settings
			locale
			features
			homeManagerConfigurations
		];
	};
}