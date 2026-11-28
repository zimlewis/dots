{ ... }: {
	flake.nixosModules.settings = { ... }: {
		nix.settings = {
			experimental-features = [ "nix-command" "flakes" ];
			# Required so non-root users are allowed to use the above substituter/keys.
			# Use @wheel for all sudo users, or list your username explicitly.
			trusted-users = ["root" "@wheel"];
            extra-substituters = [ "https://sonora.cachix.org" ];
            extra-trusted-public-keys = [ "sonora.cachix.org-1:qbPeDsvZPbwUWHpQS5Oe0bjz5oHAVscHem+MCzwrc9Q=" ];
		};

		nixpkgs.config.allowUnfree = true;
		services.udisks2.enable = true;
	};
}
