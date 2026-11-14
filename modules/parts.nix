{ lib, inputs, ... }: {
	imports = [
		inputs.flake-parts.flakeModules.modules
	];


	options = {
		flake.homeUsers = lib.mkOption {
			type = lib.types.lazyAttrsOf lib.types.deferredModule;
			default = { };
		};
	};

	config = {
		systems = [
			"x86_64-linux"
			"aarch64-linux"
		];
	};
}