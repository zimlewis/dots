{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		import-tree.url = "github:denful/import-tree";
		flake-parts.url = "github:hercules-ci/flake-parts";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			url = "github:danth/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs: inputs.flake-parts.lib.mkFlake { 
		inputs = inputs;
	} (
		inputs.import-tree ./modules
	);
}
