{ self, inputs, ... }: {
	flake.nixosModules.homeManagerConfigurations = {
		imports = [
			inputs.home-manager.nixosModules.home-manager
		];

		home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
			extraSpecialArgs = { inherit inputs; };
			users.zimlewis.imports = [ 
				self.modules.homeManager.zimlewis
			];
		};
	};
}