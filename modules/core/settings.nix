{ ... }: {
	flake.nixosModules.settings = { ... }: {
		nix.settings = {
			experimental-features = [ "nix-command" "flakes" ];
			# Required so non-root users are allowed to use the above substituter/keys.
			# Use @wheel for all sudo users, or list your username explicitly.
			trusted-users = ["root" "@wheel"];
		};
	};
}