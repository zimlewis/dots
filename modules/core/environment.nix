{ ... }: {
	flake.nixosModules.environment = { ... }: {
		environment.variables.EDITOR = "vis";
	};
}
