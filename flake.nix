{
	inputs = {
		import-tree.url = "github:denful/import-tree";
		flake-parts.url = "github:hercules-ci/flake-parts";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# zen-browser = {
		# 	url = "github:0xc000022070/zen-browser-flake";
		# 	inputs = {
		# 		nixpkgs.follows = "nixpkgs";
		# 		home-manager.follows = "home-manager";
		# 	};
		# };
	};

	outputs = inputs: inputs.flake-parts.lib.mkFlake { 
		inputs = inputs;
	} (
		inputs.import-tree ./modules
	);
}
