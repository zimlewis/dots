{ self, ... }: {
	flake.nixosModules.users = { ... }: {
		users.users.zimlewis = {
			isNormalUser = true;
			extraGroups = [ 
				"networkmanager"
				"wheel"
			];
			initialHashedPassword = "$y$j9T$44IEUCgPHcU5Wljt4rQOi1$yOAMDBo3ah8/GIOZrZYAq25SyUHuR7ozr9naniHZIr1";
		};


		home-manager.users.zimlewis.imports = [ 
			self.homeUsers.zimlewis
		];
	};
}